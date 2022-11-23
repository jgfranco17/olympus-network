# Olympus Network

A simple playground for network infrastructure tools and virtual machines. In this setup, the host machine will be the central device, networking with 3 virtual machines. Currently, this project is being developed on Linux, but should work on MacOS.

## Requirements

The following must be installed on the host machine:

* [Python 3.8](https://github.com/pyenv/pyenv) or greater
* Makefile
* [Vagrant](https://www.vagrantup.com/downloads)
* [Direnv](https://github.com/direnv/direnv)  

Everything else should be installed through the `Makefile` in a local scope only. The use of `Direnv` allows for ease of access by allowing us to load and unload environment variables depending on the current directory.
