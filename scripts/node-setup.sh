#!/bin/bash

# Update the apt packages and get a couple of basic tools
sudo apt-get update -y
sudo apt-get install unzip

# Update SSH credentials
ssh-keygen -t rsa -f vagrant-key
