VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use the bento version because it's considered friendlier for
  # multiple providers compared to the "official" Ubuntu version
  config.vm.box = "bento/ubuntu-20.04"

  # These are agent servers that run things that connect to the main host.
  config.vm.define "zeus" do |zeus|
    zeus.vm.hostname = "zeus"
    zeus.vm.network "private_network", ip: "192.168.56.2"
    # zeus.vm.network "forwarded_port", id: "ssh", host: 2205, guest: 22
    zeus.vm.provision "shell", inline: "echo Zeus box online!"
  end
  config.vm.define "poseidon" do |poseidon|
    poseidon.vm.hostname = "poseidon"
    poseidon.vm.network "private_network", ip: "192.168.56.3"
    # poseidon.vm.network "forwarded_port", id: "ssh", host: 2206, guest: 22
    poseidon.vm.provision "shell", inline: "echo Poseidon box online!"
  end
  config.vm.define "hades" do |hades|
    hades.vm.hostname = "hades"
    hades.vm.network "private_network", ip: "192.168.56.4"
    # hades.vm.network "forwarded_port", id: "ssh", host: 2207, guest: 22
    hades.vm.provision "shell", inline: "echo Hades box online!"
  end
end
