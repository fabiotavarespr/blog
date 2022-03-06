---
author: "Fabio Tavares Pereira Rego"
title: "Diferença entre Alter Table no Mysql"
date: 2022-03-04T18:00:00Z
description: "Diferença entre alter table no Mysql - ALTER vs CHANGE vs MODIFY COLUMN"
draft: true
tags:
- mysql
- cheatsheet
- reference
---

# MySQL ALTER TABLE: ALTER vs CHANGE vs MODIFY COLUMN

Sempre que eu tenho que realizar uma alteração de coluna no MySQL (atividade que não é tão frequente), eu acabou esquecendo a diferença entre ALTER COLUMN, CHANGE COLUMN e MODIFY COLUMN.

Aqui vai uma referencia para ajudar.

### ALTER COLUMN
Usado para definir ou remover o valor padrão de uma coluna.
```sql
ALTER TABLE nomeTabela ALTER COLUMN foo SET DEFAULT 'bar';
ALTER TABLE nomeTabela ALTER COLUMN foo DROP DEFAULT;
```

### CHANGE COLUMN
Usado para renomear uma coluna, alterar seu tipo de dados. 
```sql
ALTER TABLE nomeTabela CHANGE COLUMN foo foo VARCHAR(32) NOT NULL;
ALTER TABLE nomeTabela CHANGE COLUMN foo bar VARCHAR(32) NOT NULL FIRST;
ALTER TABLE nomeTabela CHANGE COLUMN foo bar VARCHAR(32) NOT NULL AFTER baz;
```

### MODIFY COLUMN
Usado para fazer tudo que CHANGE COLUMN pode fazer, mas sem renomear a coluna.
```sql
ALTER TABLE nomeTabela MODIFY COLUMN foo VARCHAR(32) NOT NULL;
```
A documentação oficial para ALTER TABLE (for MySQL 8.0) é encontrada [aqui](https://dev.mysql.com/doc/refman/8.0/en/alter-table.html).