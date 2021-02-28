IMAGE=klakegg/hugo
VERSION=0.81.0
PORT=1313

start-server:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} server -D

build:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} -D

git-init-submodule:
	@git submodule update --init --recursive

git-update-submodule:
	@git submodule update --recursive --remote