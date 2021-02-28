---
author: "Fabio Tavares Pereira Rego"
title: "Como configurar um DNS Bind9 com docker"
date: 2020-07-14T18:00:00-00:00
description: "Como configurar um DNS BIND9 utilizando uma imagem docker - Primário e Secundário"
draft: true
tags:
    - dns
    - bind9
    - docker
---

- [Introdução](#introdução)
- [Pré-requisitos](#pré-requisitos)
  - [Infraestrutura e objetivos](#infraestrutura-e-objetivos)
  - [Configurar o servidor DNS primário](#configurar-o-servidor-dns-primário)
    - [Alterações nas configurações](#alterações-nas-configurações)
  - [Configurar o servidor DNS secundário](#configurar-o-servidor-dns-secundário)
    - [Alterações nas configurações](#alterações-nas-configurações-1)
  - [Testando nosso DNS](#testando-nosso-dns)
- [Conclusão](#conclusão)

# Introdução
Neste tutorial, vamos configurar um servidor DNS, utilizando o BIND (bind9) a partir de uma imagem docker.

A imagem que utilizaremos neste Post é a do projeto [labbsr0x/docker-dns-bind9](https://github.com/labbsr0x/docker-dns-bind9), imagem implementada pela equipe do [Labbs](https://github.com/labbsr0x) do Banco do Brasil.

# Pré-requisitos
Como pré-requisito, vamos precisar das duas máquinas linux com a distribuição Ubuntu com os seguintes recursos instalados.
- [docker](https://docs.docker.com/engine/install/ubuntu/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [git](https://www.digitalocean.com/community/tutorials/como-instalar-o-git-no-ubuntu-18-04-pt)

Se você não estiver familiarizado com os conceitos do DNS, é recomendável que você assista os seguintes vídeos da [NIC.br](https://nic.br/).
- [Como funciona a Internet? Parte 3: DNS](https://www.youtube.com/watch?v=ACGuo26MswI)
- [A importância do DNS nas redes, explicada pelo NIC.br.](https://www.youtube.com/watch?v=epWv0-eqRMw)

## Infraestrutura e objetivos
Para melhor ilustar, vamos trabalhar com a seguinte infraestrutura:

- Dois servidores que serão nossos servidores de nome DNS. Vamos nos referir a eles como **ns1** e **ns2**.
- Usaremos o domínio **novodominio.com** como exemplo.
  
|Host   |Função                   |	FQDN privado          | Endereço IP privado |
|:-----:|:------------------------|:----------------------|:-------------------:|
|ns1    |Servidor DNS primário    |ns1.novodominio.com    |10.0.10.1            |
|ns2    |Servidor DNS secundário  |ns2.novodominio.com    |10.0.10.2            |


## Configurar o servidor DNS primário

Para configurar o Servidor DNS Primário, vamos utilizar a estrutura de exemplo disponível no projeto [labbsr0x/docker-dns-bind9](https://github.com/labbsr0x/docker-dns-bind9).

```text
Nota: Caso não seja do seu interesse utilizar a estrutura de exemplo, basta iniciar o container em um volume vazio, 
com isso o container iniciará uma estrutura do Bind9 nova, fique a vontade para fazer a configuração que melhor atenda 
sua realidade.
```

Dentro da máquina **ns1 (IP 10.0.10.1)**, vamos realizar as seguintes ações

Para padronizar a instalação, vamos usar com base o diretório /opt


```shell
$ cd /opt
```

Vamos realizar o clone do projeto no github, usaremos a estrutura de exemplo do projeto para ajudar na configuração.

```shell
$ git clone https://github.com/labbsr0x/docker-dns-bind9.git
```

Criaremos um diretório que será utilizado como volume do DNS

```shell
$ mkdir /opt/bind9
```

Vamos copiar a estrutura de diretório do DNS primário para o diretório que usaremos como volume do container e copiar também o arquivo de docker-compose

```shell
$ cp -r /opt/docker-dns-bind9/example/primary /opt/bind9/.

$ cp /opt/docker-dns-bind9/docker-compose.yml /opt/bind9/.
```

### Alterações nas configurações

Agora vamos alterar as configurações necessárias para configurar o Bind9.
Começaremos editando o docker-compose.yml

```shell
$ vi /opt/bind9/docker-compose.yml
```

Vamos alterar o caminho do volume de origem, onde está **./bind9** vamos trocar para **/opt/bind9/primary**, ficando da seguinte forma.

```yml
...
    volumes:
    - /opt/bind9/primary:/data # Change volume path
```

A próxima configuração será criar a zona desejada no DNS, no exemplo do [labbsr0x/docker-dns-bind9](https://github.com/labbsr0x/docker-dns-bind9) a zona está configurada como **example.com**, vamos alterar a zona para **novodominio.com**.

Para realizar essa alteração, vamos renomear o arquivo **db.example.com** para **db.novodominio.com**

```shell
$ mv /opt/bind9/primary/bind/etc/db.example.com /opt/bind9/primary/bind/etc/db.novodominio.com
```

Agora vamos realizar as alterações necessárias no arquivo de configuração da zona (**db.novodominio.com**) para ficar como proposto no objetivos.

```shell
$ vi /opt/bind9/primary/bind/etc/db.novodominio.com
```

No arquivo de configuração, vamos alterar em todos os lugares que estão **db.example.com** para **db.novodominio.com**, e na relação de domínios, vamos alterar os IPs do **ns1**, **ns2**.

Criaremos também uma entrada no DNS para simular um direcionamento para o host1.

O arquivo ficará da seguinte forma.

```yml
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     novodominio.com. root.novodominio.com. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns1.novodominio.com.
@       IN      NS      ns2.novodominio.com.
@       IN      A       127.0.0.1
@       IN      AAAA    ::1

ns1             A       10.0.10.1   ; Change to the desired NS1 IP
ns2             A       10.0.10.2   ; Change to the desired NS2 IP
```

Com o nosso arquivo de zona criado, vamos adicionar ele no **named.conf.default-zones** e realizar as configurações necessários.

```shell
$ vi /opt/bind9/primary/bind/etc/named.conf.default-zones
```

No lugar que estiver a zona **example.com** vamos alterar para **novodominio.com**, colocaremos o caminho do arquivo de zona alterando de **db.example.com** para **db.novodominio.com** e por último, colocamos o **IP do NS2 no allow-transfer**, com isso o DNS Secundário receberá as informações do DNS Primário.

O resultado da alteração será a seguinte.

```yml
...
zone "novodominio.com" { // Change to desired zone
        type master;
        file "/etc/bind/db.novodominio.com"; // Change to zone file path
        allow-transfer {10.0.10.2; };        // Change to Secondary DNS IP
//      allow-update {
//          key "example.com";
//  };
};
...
```

Vamos para dentro do diretório que está o docker-compose.yml e iniciaremos o nosso novo DNS.

```shell
$ cd /opt/bind9/

$ docker-compose up -d
```

Para verificar se o container iniciou corretamente. Execute um **docker ps -a** e veja o status ou **docker-compose logs -f** e veja o log.

## Configurar o servidor DNS secundário

A configuração do Servidor DNS secundário será bem parecido com o primário, porém mais simples.

Dentro da máquina **ns2 (IP 10.0.10.2)**, vamos realizar as seguintes ações

Para padronizar a instalação, vamos usar com base o diretório /opt

```shell
$ cd /opt
```

Vamos realizar o clone do projeto no github, usaremos a estrutura de exemplo do projeto para ajudar na configuração.

```shell
$ git clone https://github.com/labbsr0x/docker-dns-bind9.git
```

Criaremos um diretório que será utilizado como volume do DNS

```shell
$ mkdir /opt/bind9
```

Vamos copiar a estrutura de diretório do DNS secundário para o diretório que usaremos como volume do container e copiar também o arquivo de docker-compose

```shell
$ cp -r /opt/docker-dns-bind9/example/secondary /opt/bind9/.

$ cp /opt/docker-dns-bind9/docker-compose.yml /opt/bind9/.
```

### Alterações nas configurações

Agora vamos alterar as configurações necessárias para configurar o Bind9.
Começaremos editando o docker-compose.yml

```shell
$ vi /opt/bind9/docker-compose.yml
```

Vamos alterar o caminho do volume de origem, onde está **./bind9** vamos trocar para **/opt/bind9/secondary**, ficando da seguinte forma.

```yml
...
    volumes:
    - /opt/bind9/secondary:/data # Change volume path 
```

No caso do DNS Secundário, ele replica as entradas do DNS Primário, com isso não é necessário criar o arquivo db.novodominio.com.
Sendo necessário só alterar o arquivo **named.conf.default-zones** e realizar as configurações necessárias.

```shell
$ vi /opt/bind9/secondary/bind/etc/named.conf.default-zones
```

No lugar que estiver a zona **example.com** vamos alterar para **novodominio.com**, colocaremos o caminho do arquivo de zona alterando de **db.example.com** para **db.novodominio.com** e por último, colocamos o IP do NS1 na campo master, com isso o DNS Secundário sabe qual é o DNS Primário.

O resultado da alteração será a seguinte.

```yml
...
zone "novodominio.com" {  // Change to desired zone
	type slave;
	file "/etc/bind/db.novodominio.com";	// Change to zone file path
	masters {10.0.10.1;};				          // Change to Primary DNS IP
};
...
```

Vamos para dentro do diretório que está o docker-compose.yml e iniciaremos o nosso DNS Secundário.

```shell
$ cd /opt/bind9/

$ docker-compose up -d
```

Para verificar se o container iniciou corretamente. Execute um **docker ps -a** e veja o status ou **docker-compose logs -f** e veja o log.

## Testando nosso DNS

Vamos realizar um teste com o comando **dig**

```shell
$ dig -t ns novodominio.com @localhost +short

ns1.novodominio.com.
ns2.novodominio.com.
```

# Conclusão
Enfim, ao final desse processo, teremos dois servidores de DNS, primário e secundário prontos para uso.
Basta agora adicionar os hosts necessários para resolução de nomes.
