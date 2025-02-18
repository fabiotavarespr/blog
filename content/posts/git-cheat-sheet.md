---
author: "Fabio Tavares Pereira Rego"
title: "Git Cheat Sheet"
date: 2025-02-03T19:26:47Z
description: "List of git commands"
draft: true
tags:
- git
- cheatsheet
- reference
- english
---

# Git cheat sheet

Cheat sheet with useful git commands.

Whenever I find new necessary commands I will add them.

## Configuration related commands
### List the variables in the global git configuration file and their values
```shell
git config --global --list
```
### Set your name in the global git configuration file
```shell
git config --global user.name "Your Name"
```
### Set your email in the global git configuration file
```shell
git config --global user.email "Your Email"
```


## Repository related commands
### Initialize a new git repository
```shell
git init
```
### Initialize a new git repository and set the name for the initial branch to be created
```shell
git init -b <branch_name>
```


## Commands related to commits
### Show the state of the working directory and the staging area
```shell
git status
```
### Add one file to the staging area
```shell
git add <file_name>
```
### Add multiple files to the staging area
```shell
git add <file_name> <file_name> <file_name>
```
### Add all files to the staging area
```shell
git add .
```
### Add all files to the working directory that have been edited or changed to the staging area
```shell
git add -A
```
### Create a new commit with a commit message
```shell
git commit -m "Your commit message"
```
### Show a list of commits in reverse chronological order
```shell
git log
```
### Show a list of commits in reverse chronological order with the commit message
```shell
git log --oneline
```

## Commands related to branches
### List all local branches
```shell
git branch
```
### List all local branches remotes and local
```shell
git branch --all
```
### Create a new branch
```shell
git branch <branch_name>
```
### Switch to a branch
```shell
git switch <branch_name>
```
or
```shell
git checkout <branch_name>
```
### Create a new branch and switch to it
```shell
git checkout -b <branch_name>
```
or
```shell
git switch -c <branch_name>
```
### Delete a branch
```shell
git branch -d <branch_name>
```

## Commands related to merge
### Merge a branch into the current branch
```shell
git merge <branch_name>
```

## Commands related to remote repositories
### Add a remote repository
```shell
git remote add <remote_name> <remote_url>
```

### Upload changes to a remote repository
```shell
git push <remote_name> <branch_name>
```
or
```shell
git push
```

### List the remote repositories connected stored to the local repository by short name
```shell
git remote
```

### List the remote repositories connected in the local repository with short name and URL
```shell
git remote -v
```

### Clone a remote repository
```shell
git clone <remote_url> <local_directory>
```

### Download changes from a remote repository
```shell
git fetch
```
or
```shell
git fetch <remote_name>
```

### Delete a remote branch
```shell
git push <remote_name> --delete <branch_name>
```

### Remove remote-tracking branches that correspond to deleted remote branches and download changes from a remote repository
```shell
git fetch --prune
```
or
```shell
git fetch -p
```

### Fetch and integrate changes from a remote repository
```shell
git pull <remote_name> <branch_name>
```

### If an upstream branch is defined, fetch and integrate changes from a remote repository
```shell
git pull
```

## Commands related to merge
### Merge a branch into the current branch
```shell
git merge
```

### Stop a merge in progress
```shell
git merge --abort
```

## Commands related to rebase
### Rebase the current branch on top of another branch
```shell
git rebase <branch_name>
```

### Continue a rebase in progress after resolving conflicts
```shell
git rebase --continue
```

### Stop a rebase in progress
```shell
git rebase --abort
```

### Restore a file to another version of the file in the staging area
```shell
git restore --staged <file_name>
```

## Commands related to stash
### Save changes in the working directory and staging area in a stash
```shell
git stash
```

### List all stashes
```shell
git stash list
```

### Create a stash with a message
```shell
git stash save <message>
```
or
```shell
git stash create <message>
```

### Apply the changes in the last stash to the working directory and staging area
```shell
git stash apply
```

### Apply the changes in the last stash to the working directory and staging area and remove the stash
```shell
git stash pop
```

### Apply the changes in a specific stash to the working directory and staging area
```shell
git stash apply stash@{<stash_number>}
```

### Apply the changes in a specific stash to the working directory and staging area and remove the stash
```shell
git stash pop stash@{<stash_number>}
```

### Remove the last stash
```shell
git stash drop
```

### Remove a specific stash
```shell
git stash drop stash@{<stash_number>}
```

### Clear all stashes
```shell
git stash clear
```