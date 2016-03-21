# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end

  config.vm.provision "shell" do |s|
    path: "./scripts/provision/general.sh"
  end

  (1..3).each do |i|
    config.vm.define "server#{i}" do |node|
      node.vm.hostname = "server#{i}.example.com"
      node.vm.network "private_network", ip: "192.0.2.#{i+1}"
    end
  end

  config.vm.define "router" do |n1|
    n1.vm.hostname = "router.example.com"
    n1.vm.network "private_network", ip: "192.0.2.40"
  end

  config.vm.define "dockernode01" do |n2|
      n1.vm.hostname = "dockernode01.example.com"
      n1.vm.network "private_network", ip: "192.0.2.50"
  end
end