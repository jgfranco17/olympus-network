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
create-venv name:
    python3 -m venv {{name}}

# Print current Python version and location
python-version:
    @echo "Using $(python --version) from $(which python)"

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

# Run an Ansible playbook
ansible-play playbook:
    cd ansible && ../olympus-venv/bin/ansible-playbook -i inventory.yaml {{playbook}}

# Get available inventory
get-ansible-configs:
    @echo "Available Ansible configs:"
    @find ./ansible/ -maxdepth 1 -type f -name "*.yaml" -o -name "*.yml"

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
