.PHONY: build deps compile test run-tests rebuild doco start stop destroy

# Variables
CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL := ${shell which bash}

default: build

build: deps start

deps:
	docker run --rm --interactive --volume $(CURRENT_DIR):/app node npm install

compile: 
	docker run --rm --interactive --volume $(CURRENT_DIR):/app node npm run build

test: 
	@docker exec xtech_cicd-node make run-tests

run-tests: 
	npm test

start: CMD=up -d  
stop: CMD=stop
destroy: CMD=down 

doco start stop destroy: 
	@docker-compose $(CMD)
