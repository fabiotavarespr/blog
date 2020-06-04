+++
author = "Fabio Tavares"
title = "Introdução a sistema de versionamento - SCM"
date = 2020-06-03T20:23:05-03:00
description = "Introdução a sistema de versionamento"
draft = true
hidden = true
tags = [
    "git",
    "versionamento",
]
+++

Vejo situações que desenvolvedores ou pessoas da área de tecnologia começarem a usar algo para resolver um problema ou porque está todo mundo usando, e nem param para entender sobre a origem daquilo.

Um desses casos é o [*git*](https://git-scm.com/).

É muito comum novatos começarem a usar o [github](https://github.com/about) ou [gitlab](https://about.gitlab.com/), porque na empresa que estão iniciando ou no estágio que estão fazendo todos usam para versionar o código fonte, fazem um monte de comandos, como, git clone, git add, git commit, git pull e git push, mas no fundo, nem entendem o que estão fazendo, só olham o amiguinho do lado fazendo, pedem uma ajuda e fazem igual.

Mas vamos lá? Git, github e gitlab são as mesmas coisas?

A resposta é não.

Para explicar melhor, vamos começar falando sobre [sistema de controle de versão](https://pt.wikipedia.org/wiki/Sistema_de_controle_de_vers%C3%B5es) (ou versionamento) ou ainda SCM (do inglês source code management) .

Antigamente, no início da computação não existia toda essa tecnologia que estamos acostumados no nosso dia-a-dia como internet, wifi ou rede de computador. Para escrever um programa, as pessoas escreviam um arquivo no computador, para outra pessoa ter acesso, precisava gravar em um disquete, levar até a outra pessoa, entregar o disquete e assim passar para o outro computador.

![Disquete](https://fabiotavarespr.dev/images/disquete.png)

Para desenvolver sistemas e trabalhar em equipe, isso era inviável, com o tempo surgiu a rede de computador e era possível enviar arquivos pela rede e os disquetes foram saindo de cena.

Surgiu então o sistema de versionamento, eles funcionavam de forma centralizada/linear, onde existia um único repositório para todos os participantes, você precisa estar conectado em um servidor para enviar os arquivos ou para pegar arquivos criados/alterados por outra pessoa.

{Imagem versionamento centralizado.}

Alguns dos sistemas de versionamentos centralizados mais conhecidos são [CVS](https://savannah.nongnu.org/projects/cvs) e [SVN](https://subversion.apache.org/).
Porém o grande problema desse tipo de SCM é caso a rede esteja indisponível ou caso o servidor esteja fora do ar, você não poderia versionar código ou pegar alteração da sua equipe.

Assim surgiu o conceito de  SCM distribuídos.

{Imagem versionamento distribuído.}

O SCM distribuído mais conhecido atualmente é o [git](https://git-scm.com/), mas ele não é o único. Existe também o [Mercurial](https://www.mercurial-scm.org/) e o [BitKeeper](http://www.bitkeeper.org/).

---------------

Com o SCM distribuídos cada local que tem o repositório tem um repositório completo de todos os arquivos.
Na sua máquina tem um repositório completo, na máquina do seu amigo que versionou o código tem um repositório completo, no github tem um repositório completo e no gitlab tem um repositório completo.

Todo mundo que já fez um trabalho no computador, e precisou ficar salvando um arquivo já precisou de um sistema de controle de versão é não sabia que precisava. Principalmente se fez uma trabalho de conclusão de curso - TCC.
Começou o trabalho, escreveu várias coisas, salvou e foi dormir.
No outro dia, continuou escrevendo e alterou coisas que foram escritas no primeiro dia e salvou.
No terceiro dia, continuou fazendo o trabalho, mas lendo percebeu que o que tinha escrito no primeiro dia estava melhor, mas alterou no segundo e não lembra direito como estava.

Com isso, começa a salvar o arquivo com nomes diferentes para cada dia ter um arquivo novo, assim começa a criar TCC-versao-01.txt, no outro dia TCC-versao-02.txt e assim vai até chegar no TCC-versao-final.txt, TCC-versao-final02.txt e o TCC-versao-final-de-verdade.txt e parece que nunca acaba.

O que é um sistema de controle de versão?

Um sistema de controle de versão (ou versionamento) é uma forma de registrar alterações realizadas em arquivos, de forma que é possível saber quem alterou, quando alterou e o que alterou.
Com isso é analisar se a versão anterior estava melhor

"Um sistema de controle de versões (ou versionamento), VCS (do inglês version control system) ou ainda SCM (do inglês source code management) na função prática da Ciência da Computação e da Engenharia de Software, é um software que tem a finalidade de gerenciar diferentes versões no desenvolvimento de um documento qualquer. Esses sistemas são comumente utilizados no desenvolvimento de software para controlar as diferentes versões — histórico e desenvolvimento — dos códigos-fontes e também da documentação."

Vamos começar com uma pergunta básica, git, github e gitlab são as mesmas coisas?

A resposta é não!!!

"Git é um sistema de controle de versões distribuído, usado principalmente no desenvolvimento de software, mas pode ser usado para registrar o histórico de edições de qualquer tipo de arquivo."1

GitHub é uma plataforma de hospedagem de código-fonte com controle de versão usando o Git.
GitLab é um gerenciador de repositório de software baseado em git, com suporte a Wiki, gerenciamento de tarefas e CI/CD.[2] 







