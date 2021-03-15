---
author: "Fabio Tavares Pereira Rego"
title: "Docker Cheat Sheet"
date: 2021-03-15T12:14:01Z
description: "Lista de comandos docker"
draft: true
tags:
    - docker
    - cheatsheet
---

# Docker Cheat Sheet

Cheat Sheet com comandos docker úteis.

Sempre que encontrar novos comandos necessários irei adicionando.


### Lista todas as imagens docker
```shell
docker images -a
```

### Lista todos os containers rodando
```shell
docker ps
```

### Lista todos os containers
```shell
docker ps -a
```

### Inicia container
```shell
docker run <nome_da_imagem>
```

### Inicia container e remove ele quando parar
```shell
docker run --rm <nome_da_imagem>
```

### Inicia container usando a rede do host e remove ele quando parar
```shell
docker run --rm --network host <nome_da_imagem>
```

### Inicia container existente
```shell
docker start <nome_do_container> ou <id_do_container>
```

### Para container
```shell
docker stop <nome_do_container> ou <id_do_container>
```

### Mata todos os container
```shell
docker kill $(docker ps -q)
```

### Visualiza log do container
```shell
docker logs <nome_do_container> ou <id_do_container>
```

### Visualiza log do container em tempo real
```shell
docker logs -f <nome_do_container> ou <id_do_container>
```

### Deleta todos os container
Use forçar -f para deletar docker rodando.
```shell
docker rm $(docker ps -a -q)
```

### Deleta imagem
```shell
docker rmi <nome_da_imagem>
```

### Deleta todas as imagens
```shell
docker rmi $(docker images -q)
```

### Deleta todas as imagens sem pendências
```shell
docker rmi $(docker images -q -f dangling=true)
```

### Deleta volumes sem pendências
```shell
docker volume rm -f $(docker volume ls -f dangling=true -q)
```

### Entra no container via ssh local
```shell
sudo docker exec -it <nome_do_container> bash
```