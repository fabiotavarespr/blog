IMAGE=klakegg/hugo
VERSION=0.79.1
PORT=1313

start-server:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} server -D

build:
	@docker run --rm -it -v $(shell pwd):/src -p ${PORT}:${PORT} ${IMAGE}:${VERSION} -D
