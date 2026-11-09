# Per-developer overrides (container runner, image name, port) go in .makefile.env.

.PHONY: help image-build image-run image-stop image-clean

-include .makefile.env
DOCKER_RUNNER  ?= podman
IMAGE_NAME     ?= registry.km8.es/keenmate-dev-schemas:prod
CONTAINER_NAME ?= keenmate-dev-schemas
IMAGE_PORT     ?= 12000

help: ## Show this help message
	@echo "Available targets:"
	@grep -hE '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-18s %s\n", $$1, $$2}'

# ── Container image ──────────────────────────────────────────────────────────

image-build: ## Build the schemas container image
	$(DOCKER_RUNNER) build -t $(IMAGE_NAME) .

image-run: ## Run the schemas image on IMAGE_PORT (default 12000)
	-@$(DOCKER_RUNNER) rm -f $(CONTAINER_NAME) >/dev/null 2>&1
	$(DOCKER_RUNNER) run -d --name $(CONTAINER_NAME) -p $(IMAGE_PORT):8080 $(IMAGE_NAME)
	@echo "Serving schemas at http://localhost:$(IMAGE_PORT)"

image-stop: ## Stop and remove the schemas container
	-@$(DOCKER_RUNNER) rm -f $(CONTAINER_NAME) >/dev/null 2>&1

image-clean: image-stop ## Remove the schemas container and image
	-@$(DOCKER_RUNNER) rmi $(IMAGE_NAME) >/dev/null 2>&1

.DEFAULT_GOAL := help
