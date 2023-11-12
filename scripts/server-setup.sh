#!/bin/bash
NOMAD_VERSION=1.4.1
CONSUL_VERSION=1.9.6
VAULT_VERSION=1.7.2

# Update the apt packages and get a couple of basic tools
sudo apt-get update -y
sudo apt-get install unzip

echo "Preparing to install services..."

# install Nomad
mkdir -p bin
curl -o bin/nomad.zip \
	"https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"
cd bin
unzip nomad.zip
rm bin/nomad.zip

echo "Nomad installed."

# mkdir -p bin
# curl -o bin/consul.zip \
# 	https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_${OS_URL}_amd64.zip
# cd bin && unzip consul.zip
# rm bin/consul.zip
#
# echo "Consul installed."

mkdir vagrant
echo "Central server is ready to go!"
