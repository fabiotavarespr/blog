IMAGE=klakegg/hugo
VERSION=0.107.0
PORT=1313
NEW_POST='SET NEW POST'

all: help

start-server: ## Started local server
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} server -D

build: ## Create a new build
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} -D

new-post: ## Create a new post, needed set NEW_POST
ifeq ($(NEW_POST), 'SET NEW POST')
	@echo 'Set NEW_POST path, example NEW_POST=posts/new_post.md'
else
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} new $(NEW_POST)
endif

git-init-submodule: ## Init submodules
	@git submodule update --init --recursive

git-update-submodule: ## Update submodules
	@git submodule update --recursive --remote

help: ## Display help screen
	@echo "Usage:"
	@echo "	make [COMMAND]"
	@echo "	make help \n"
	@echo "Commands: \n"
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[33m%-30s\033[36m %s\n", $$1, $$2}'