.PHONY: all build deps lint check-goos
SHELL=/bin/bash

ifeq ($(OS),Windows_NT)
    OSNAME = windows
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        OSNAME = linux
    endif
    ifeq ($(UNAME_S),Darwin)
        OSNAME = darwin
    endif
endif

ifdef os
  OSNAME=$(os)
endif

all: unit_test lint build

build: unit_test
	CGO_ENABLED=0 GOOS=linux go build -mod=vendor -ldflags="-s -w" -a -o ./artifacts/svc-unpacked ./cmd/xo
	rm -rf ./artifacts/svc
	upx -q -o ./artifacts/svc ./artifacts/svc-unpacked

deps:
	go mod vendor

unit_test:
	go test -v -mod=vendor -cover $$(go list ./...)

lint:
	# (cd /tmp/; go get -u github.com/golangci/golangci-lint/...)
	# go install github.com/golangci/golangci-lint/cmd/golangci-lint
	golangci-lint run