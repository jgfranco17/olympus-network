# Setup
NOMAD_VERSION := "1.6.1"
CONSUL_VERSION := "1.14.1"
OS_URL := "linux"

# Main help command
default:
    @just --list

# Start VMs
startup:
    @echo "Loading up Olympus systems..."
    vagrant validate
    vagrant up
    @echo "Ready to go!"

# Create a virtual environment
create-venv:
    python3 -m venv olympus-venv

python-version:
    @echo "Using Python $(python --version)"

# Start the Nomad dev server
run-nomad-server:
    sudo bin/nomad agent -dev -bind 0.0.0.0 -log-level INFO

# Install Hashicorp suite
setup: install-nomad install-consul
    @echo "Installed Nomad and Consul!"

# Clean up the virtual machines
clean:
    @echo "Removing VMs..."
    vagrant destroy -f
    @echo "Cleaned all Vagrant files."

# Configure Ansible playbook
ansible-setup:
    cd ansible && ../olympus-venv/bin/ansible-playbook -i inventory.yaml playbook.yaml

# Sanity check for Ansible
ansible-ping:
    cd ansible && ../olympus-venv/bin/ansible -m ping -i inventory.yaml olympians

# Install Python requirements
install-requirements:
    ./olympus-venv/bin/pip install --upgrade pip
    ./olympus-venv/bin/pip install wheel
    ./olympus-venv/bin/pip install -r requirements.txt

# Local Nomad
install-nomad:
    mkdir -p bin
    @echo "Downloading Nomad v{{NOMAD_VERSION}}..."
    curl -o bin/nomad.zip \
        https://releases.hashicorp.com/nomad/{{NOMAD_VERSION}}/nomad_{{NOMAD_VERSION}}_{{OS_URL}}_amd64.zip
    cd bin && unzip nomad.zip
    rm bin/nomad.zip
    @echo "Nomad ready!"

# Local Consul
install-consul:
    mkdir -p bin
    @echo "Downloading Consul v{{CONSUL_VERSION}}..."
    curl -o bin/consul.zip \
        https://releases.hashicorp.com/consul/{{CONSUL_VERSION}}/consul_{{CONSUL_VERSION}}_{{OS_URL}}_amd64.zip
    cd bin && unzip consul.zip
    rm bin/consul.zip
    @echo "Consul ready!"
