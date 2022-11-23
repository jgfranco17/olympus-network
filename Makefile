# Setup
NOMAD_VERSION := 1.4.1
CONSUL_VERSION := 1.9.6
VAULT_VERSION := 1.7.2

ifeq ($(shell uname), Darwin)
OS_URL := darwin
else
OS_URL := linux
endif

.PHONY: run
run:
	@echo Loading up Olympus systems...
	@vagrant validate
	@vagrant up
	@echo Ready to go!

.PHONY: run-nomad-server
run-nomad-server: 
	@sudo nomad agent -dev -bind 0.0.0.0 -log-level INFO

.PHONY: setup
setup: bin/nomad bin/consul bin/vault
	@echo Installed Nomad, Consul, and Vault!

.PHONY: clean
clean:
	@echo Removing VMs...
	@vagrant destroy -f
	@echo Cleaned all Vagrant files.

.PHONY: ping-all
ping-all: .venv/bin/ansible
	@cd ansible && ../.venv/bin/ansible -i inventory.yaml all -m ping

.PHONY: install-pyreqs
install-pyreqs:
	./.venv/bin/pip install -r requirements.txt

# Local pip
.venv/bin/pip:
	python -m venv .venv

# Local ansible
.venv/bin/ansible: .venv/bin/pip
	./.venv/bin/pip install ansible

# Local Nomad
bin/nomad:
	@mkdir -p bin
	curl -o bin/nomad.zip \
		https://releases.hashicorp.com/nomad/$(NOMAD_VERSION)/nomad_$(NOMAD_VERSION)_$(OS_URL)_amd64.zip
	@cd bin && unzip nomad.zip
	@rm bin/nomad.zip
	@echo Nomad ready!

# Local Consul
bin/consul:
	@mkdir -p bin
	curl -o bin/consul.zip \
		https://releases.hashicorp.com/consul/$(CONSUL_VERSION)/consul_$(CONSUL_VERSION)_$(OS_URL)_amd64.zip
	@cd bin && unzip consul.zip
	@rm bin/consul.zip
	@echo Consul ready!
