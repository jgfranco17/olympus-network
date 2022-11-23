VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use the bento version because it's considered friendlier for 
  # multiple providers compared to the "official" Ubuntu version
  config.vm.box = "bento/ubuntu-20.04"

  # These are agent servers that run things that connect to the main host.
  config.vm.define "zeus" do |zeus|
    zeus.vm.hostname = "zeus"
    zeus.vm.network "private_network", ip: "192.168.56.2"
    zeus.vm.provision "shell", inline: "scripts.install-nomad.sh"
  end
  config.vm.define "poseidon" do |poseidon|
    poseidon.vm.hostname = "poseidon"
    poseidon.vm.network "private_network", ip: "192.168.56.3"
    poseidon.vm.provision "shell", inline: "scripts.install-nomad.sh"
  end
  config.vm.define "hades" do |hades|
    hades.vm.hostname = "hades"
    hades.vm.network "private_network", ip: "192.168.56.4"
    hades.vm.provision "shell", inline: "scripts.install-nomad.sh"
  end
end