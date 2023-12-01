SHELL := /bin/bash

.PHONY: help test
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

new:    ## Start a new day in Ruby
	@test ! -d $$(date "+%Y")/$$(date "+%-d") && \
	mkdir -p $$(date "+%Y")/$$(date "+%-d") && \
	cp templates/main.rb $$(date "+%Y")/$$(date "+%-d")/main.rb && \
	cp templates/main_test.rb $$(date "+%Y")/$$(date "+%-d")/main_test.rb && \
	touch $$(date "+%Y")/$$(date "+%-d")/input.data

new_python:	## Start a new day in Python
	@test ! -d $$(date "+%Y")/$$(date "+%-d") && \
	mkdir -p $$(date "+%Y")/$$(date "+%-d") && \
	cp templates/main.py $$(date "+%Y")/$$(date "+%-d")/main.py && \
	cp templates/test_main.py $$(date "+%Y")/$$(date "+%-d")/test_main.py && \
	touch $$(date "+%Y")/$$(date "+%-d")/input.data

test:	## Run today tests
	@ruby $$(date +%Y)/$$(date +%-d)/main_test.rb

test_python:	## Run today tests in Python
	@python -m unittest discover -s $$(date +%Y)/$$(date +%-d)/
