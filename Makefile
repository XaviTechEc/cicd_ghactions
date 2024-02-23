.PHONY: build deps npm-install npm-update npm reload test run-tests start stop destroy doco rebuild start-local

# Variables
CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL := ${shell which bash}

default: build

build: deps start

deps: npm-install 

npm-install: CMD=install 
npm-update: CMD=update
npm npm-install npm-update: 
	@docker run --rm --interactive --volume $(CURRENT_DIR):/app --user $(id -u):$(id -g) \
					node npm $(CMD) --loglevel=warn

test: 
	docker exec xtech_cicd-node npm test

start: CMD=up -d  
stop: CMD=stop
destroy: CMD=down 

doco start stop destroy: 
	@docker-compose $(CMD)