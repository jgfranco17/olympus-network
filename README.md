<h1 align="center">The Olympus Network</h1>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE.md)

</div>

---

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [TODO](./TODO.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgements)

## 🔎 About <a name = "about"></a>

A simple playground for software infrastructure tools and virtual machines. In this setup, the host machine will be the central device, networking with 3 virtual machines. Currently, this project is being developed on Linux, but should work on MacOS. Eventually, I plan to implement Infrastructure as Code (IaC) technologies for VM setup.

## ⚙️ Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

The following must be installed on the host machine:

- [Python 3.8](https://github.com/pyenv/pyenv) or greater
- [Makefile](https://www.gnu.org/software/make/manual/make.html)
- [Vagrant](https://www.vagrantup.com/downloads)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Direnv](https://github.com/direnv/direnv)

It is highly recommended to use `pyenv` to manage Python versions. Everything else should be installed through the `Makefile` in a local scope only. The use of `direnv` allows for ease of access by allowing us to load and unload environment variables depending on the current directory.

## 🚀 Usage <a name="usage"></a>

In order to start up the Olympus Network machines, you can use the following command. Aside from enacting the standard `vagrant up`, this command first validates the Vagrantfile configuration before running.

```bash
# Start the Vagrant machines
make startup
```

If you want to use Ansible, we can configure a virtual environment to isolate the installation to local scope.

```bash
# Set up a Python3 virtual env, name it ".venv" for compatibility with the Makefile
python -m venv .venv

# Install Python prerequisites using local pip
make install-requirements
```

To remote connect into any of the virtual machines, we can use Vagrant's built-in ssh command. This allows us to connect via hostname rather than IP address.

```bash
# Connect to VM
vagrant ssh [zeus|poseidon|hades]
```

If you wish to completely wipe the environment and tear down the virtual machines, simply run:

```bash
# Destroys the Vagrant VMs and related drives
make clean
```

## ✍️ Authors <a name = "authors"></a>

- [Chino Franco](https://github.com/jgfranco17)

## 🎉 Acknowledgements <a name = "acknowledgements"></a>

Special thanks to [Brandon Fulljames](https://github.com/Evertras) for the project that served as an inspiration for this build.
