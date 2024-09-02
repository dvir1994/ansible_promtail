# Define variables
ANSIBLE_PLAYBOOK=site.yml
INVENTORY=inventory.ini
ANSIBLE_CONFIG=ansible.cfg

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  install-dependencies			Install Ansible dependencies (community.general)"
	@echo "  lint           			Lint Ansible playbooks and roles (ansible-lint required)"
	@echo "  run            			Run the Ansible playbook"
	@echo "  create-vault				Creating Ansible vault"
	@echo "  edit-vault				Edit the created Ansible vault"
	@echo ""

# Install dependencies
.PHONY: install-dependencies
install-dependencies:
	@echo "###########################################"
	@echo "### Installing dependencies ###"
	@echo "###########################################"
	@ansible-galaxy collection install community.general --force

# Lint Ansible playbooks and roles
.PHONY: lint
lint:
	@echo "###########################################"
	@echo "### Linting Ansible playbooks and roles ###"
	@echo "###########################################"
	@find . -name "*.yml" ! -name "vault.yml" | xargs ansible-lint 2>&1 | grep -v "PATH altered to include"

# Run the Ansible playbook
.PHONY: run
run:
	@echo "###########################################"
	@echo "### Running Ansible playbook ###"
	@echo "###########################################"
	@echo ""
	@ansible-playbook -i $(INVENTORY) $(ANSIBLE_PLAYBOOK) --ask-vault-pass

# Create Ansible vault
.PHONY: create-vault
create-vault:
	@echo "###########################################"
	@echo "### Creating Ansible vault ###"
	@echo "###########################################"
	@ansible-vault create group_vars/all/vault.yml

# Edit the created Ansible vault
.PHONY: edit-vault
edit-vault:
	@echo "###########################################"
	@echo "### Edit Ansible vault values ###"
	@echo "###########################################"
	@ansible-vault edit group_vars/all/vault.yml

