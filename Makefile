.PHONY: build deps compile test run-tests rebuild doco start stop destroy

# Variables
SHELL := $(shell which bash)

default: build

build: deps start

deps:
	docker run --rm --interactive --volume $(PWD):/app node npm install

compile: 
	docker run --rm --interactive --volume $(PWD):/app node npm run build

test: 
	@docker exec xtech_cicd-node make run-tests

run-tests: 
	npm test

start: CMD=up -d  
	docker-compose up xtech_cicd-node
	
stop: CMD=stop
destroy: CMD=down 

doco start stop destroy: 
	@docker-compose $(CMD)
