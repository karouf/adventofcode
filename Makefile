SHELL := /bin/bash

.PHONY: help test
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

new:	## Start a new day
	@test ! -d $$(date "+%Y")/$$(date "+%-d") && \
	mkdir -p $$(date "+%Y")/$$(date "+%-d") && \
	cp template.py $$(date "+%Y")/$$(date "+%-d")/main.py && \
	cp test_template.py $$(date "+%Y")/$$(date "+%-d")/test_main.py && \
	touch $$(date "+%Y")/$$(date "+%-d")/input.data

test:	## Run today tests
	@python -m unittest discover -s $$(date +%Y)/$$(date +%-d)/
