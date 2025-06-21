SHELL = /bin/bash
.DEFAULT_GOAL := help
HERE := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

# https://mwop.net/blog/2023-12-11-advent-makefile.html
##@ Help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: frankenphp workerman bench ## Do everything

# ### #

.PHONY: frankenphp
frankenphp: ## Start the frankenphp test server
	@echo
	@echo "--> FrankenPHP: starting server"
	frankenphp php-server --listen 127.0.0.1:4646 --worker ./frankenphp.php
	@echo

.PHONY: workerman
workerman: ## Start the workerman test server
	@echo
	@echo "--> Workerman: starting server"
	php workerman.php start
	@echo

.PHONY: bench
bench: ## Run the oha benchmarks
	@echo
	@echo "--> Bench: Running oha benchmark"
	oha -z 60s http://127.0.0.1:4646
	@echo
