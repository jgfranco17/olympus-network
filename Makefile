# Setup
NOMAD_VERSION := 1.4.2
CONSUL_VERSION := 1.14.1

ifeq ($(shell uname), Darwin)
OS_URL := darwin
else
OS_URL := linux
endif

.PHONY: startup
startup:
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

.PHONY: ansible-setup
ansible-setup: venv/bin/ansible
	@cd ansible && ../venv/bin/ansible-playbook -i inventory.yaml playbook.yaml

.PHONY: ansible-ping
ansible-ping: venv/bin/ansible
	@cd ansible && ../venv/bin/ansible -m ping -i inventory.yaml olympians

.PHONY: install-requirements
install-requirements:
	./venv/bin/pip install --upgrade pip
	./venv/bin/pip install wheel
	./venv/bin/pip install -r requirements.txt

.PHONY: enable-venv
enable-venv:
	@source ./venv/bin/activate

# Local pip
venv/bin/pip:
	python -m venv venv

# Local ansible
venv/bin/ansible: venv/bin/pip
	./venv/bin/pip install ansible

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
