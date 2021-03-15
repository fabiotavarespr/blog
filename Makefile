IMAGE=klakegg/hugo
VERSION=0.81.0
PORT=1313
NEW_POST='SET NEW POST'

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

all: help

start-server:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} server -D

build:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} -D

new-post:
ifeq ($(NEW_POST), 'SET NEW POST')
	@echo 'Set NEW_POST path, example NEW_POST=posts/new_post.md'
else
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} new $(NEW_POST)
endif

git-init-submodule:
	@git submodule update --init --recursive

git-update-submodule:
	@git submodule update --recursive --remote

help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@echo "  ${YELLOW}start-server		${RESET} ${GREEN}Started local server${RESET}"
	@echo "  ${YELLOW}build			${RESET} ${GREEN}Create a new build${RESET}"
	@echo "  ${YELLOW}new-post		${RESET} ${GREEN}Create a new post, needed set NEW_POST${RESET}"
	@echo "  ${YELLOW}git-init-submodule	${RESET} ${GREEN}Init submodules${RESET}"
	@echo "  ${YELLOW}git-update-submodule	${RESET} ${GREEN}Update submodules${RESET}"
	@echo "  ${YELLOW}help			${RESET} ${GREEN}Show this help message${RESET}"