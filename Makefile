.PHONY: help start stop start-backend stop-backend start-frontend stop-frontend

# Default target
.DEFAULT_GOAL := help

## Help command
help: ## Mutasd a segítséget
	@echo "Elérhető parancsok:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

## Projekt kezelés
start: start-backend start-frontend ## Backend és Frontend indítása

stop: stop-backend ## Backend és Frontend leállítása

start-backend: ## Backend indítása (Docker konténerek démon módban)
	cd ../backend && $(MAKE) upd

stop-backend: ## Backend leállítása (Docker konténerek leállítása)
	cd ../backend && $(MAKE) down

start-frontend: ## Frontend dev szerver indítása
	cd ../frontend && $(MAKE) start

stop-frontend: ## Frontend dev szerver leállítása
	@echo "Használd Ctrl+C-t a frontend dev szerver leállításához"

