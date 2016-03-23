# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end

  config.vm.provision "shell", path: "./scripts/provision/general.sh"
  config.vm.provision "shell", path: "./scripts/provision/docker.sh"

  config.vm.define "server" do |n|
    n.vm.hostname = "server.example.com"
    n.vm.network "private_network", ip: "192.0.2.10"
  end

  config.vm.define "router" do |n|
    n.vm.hostname = "router.example.com"
    n.vm.network "private_network", ip: "192.0.2.20"
  end

  config.vm.define "node" do |n|
    n.vm.hostname = "dockernode01.example.com"
    n.vm.network "private_network", ip: "192.0.2.30"
  end
end