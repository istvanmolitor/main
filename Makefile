.PHONY: help start stop start-backend stop-backend start-frontend stop-frontend clone-backend install-backend clone-frontend install-frontend clone install

# Default target
.DEFAULT_GOAL := help

## Help command
help: ## Mutasd a segítséget
	@echo "Elérhető parancsok:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

## Telepítés
clone: clone-backend clone-frontend ## Backend és Frontend repository klónozása

install: install-backend install-frontend ## Backend és Frontend projekt telepítése

clone-backend: ## Backend repository klónozása
	cd .. && git clone git@github.com:istvanmolitor/backend.git

install-backend: ## Backend projekt telepítése
	cd ../backend && composer install && npm install

clone-frontend: ## Frontend repository klónozása
	cd .. && git clone git@github.com:istvanmolitor/frontend.git

install-frontend: ## Frontend projekt telepítése
	cd ../frontend && npm install

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

