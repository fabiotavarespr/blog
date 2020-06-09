---
author: "Fabio Tavares Pereira Rego"
title: "Alterando repositório remote no git"
date: 2020-06-04T11:27:07-03:00
description: "Como levar seu código do gitlab para o github (ou vice-versa) sem perder seu histórico?"
draft: true
tags:
    - git
    - versionamento
---

Sempre que versionamos nossos código no git, utilizamos um sistema de versionamento distribuído.

Com isso é possível alterar o repositório remoto do [gitlab](https://about.gitlab.com/) para o [github](https://github.com/about) ou vice-versa, sem perder o histórico de alteração, como os commits, quem alterou e o que alterou, resumindo, toda a rastreabilidade das alterações versionadas.

## Como fazemos isso?

Para exemplificar, vamos utilizar o repositório criado para esse post no github e levar para o gitlab. O repositório é [alterando-repositorio](https://github.com/fabiotavarespr/alterando-repositorio.git).

Com o projeto versionado no github e já sincronizado.

![Relação de commits no repositório remoto do github](https://fabiotavarespr.dev/images/commits-github.png)

No diretório do projeto vamos listar os repositórios remotos com o seguinte comando

```shell
$ git remote -v
```

Como retorno, temos os repositórios remotos existentes.

```sh
origin  https://github.com/fabiotavarespr/alterando-repositorio.git (fetch)
origin  https://github.com/fabiotavarespr/alterando-repositorio.git (push)
```
## Origin

O nome do repositório padrão é *origin*, esse nome é definido  no  copia e cola que o github ou gitlab apresenta quando criamos nossos projetos e faz o primeiro commit, mas as pessoas nem param para pensar, então depois executam *git push* e *git pull* e vão trabalhando automaticamente.

Para visualizar melhor, vamos mudar esse nome para github.

```sh
$ git remote rename origin github
```
Listando os repositórios novamente, e veremos o resultado da alteração

```sh
$ git remote -v  

github  https://github.com/fabiotavarespr/alterando-repositorio.git (fetch)
github  https://github.com/fabiotavarespr/alterando-repositorio.git (push)
```

## Adicionando o repositório remoto do gitlab e sincronizando os repositórios.

Para adicionar o repositório remoto do gitlab no nosso repositório local vamos executar o seguinte comando.

```sh
$ git remote add gitlab https://gitlab.com/fabiotavarespr/alterando-repositorio.git
```

Com isso adicionamos o repositório remoto do gitlab, nomeamos ele como gitlab, ficando da seguinte forma a listagem dos repositórios.

```sh
$ git remote -v 

github  https://github.com/fabiotavarespr/alterando-repositorio.git (fetch)
github  https://github.com/fabiotavarespr/alterando-repositorio.git (push)
gitlab  https://gitlab.com/fabiotavarespr/alterando-repositorio.git (fetch)
gitlab  https://gitlab.com/fabiotavarespr/alterando-repositorio.git (push)
```

Próximo passo agora, é sincronizar o repositório local com o repositório remoto, para isso vamos executar

```sh
$ git push -u gitlab --all
$ git push -u gitlab --tags
```

Conferindo os commits no gitlab, análise que eles ficam com o mesmo hash que no github, mantendo toda a rastreabilidade do código nos dois repositórios remotos, como prometido

![Relação de commits no repositório remoto do gitlab](https://fabiotavarespr.dev/images/commits-gitlab.png)

Para remover qualquer um dos repositórios remotos basta executar *git remote remove $NOME_REPOSITORIO*, como exemplo.
```sh
$ git remote remove github
```

Para renomear um dos repositórios remotos basta executar *git remote remove $NOME_REPOSITORIO*, como exemplo.
```sh
$ git remote rename gitlab origin
```

Ficando no final assim, somente o repositório remoto do gitlab, com o nome origin.
```sh
$ git remote -v

origin  https://gitlab.com/fabiotavarespr/alterando-repositorio.git (fetch)
origin  https://gitlab.com/fabiotavarespr/alterando-repositorio.git (push)
```


## Referências
- https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
- https://about.gitlab.com
- https://github.com/about
