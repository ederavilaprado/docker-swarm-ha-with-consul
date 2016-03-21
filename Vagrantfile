# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<SCRIPT

echo Installing dependencies...
sudo apt-get update
sudo apt-get install -y unzip curl htop jq

echo Fetching Consul...
cd ~
wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip -O consul.zip

echo Installing Consul...
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d

SCRIPT

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end

  config.vm.provision "shell", inline: $script

  (1..3).each do |i|
    config.vm.define "server#{i}" do |node|
      node.vm.hostname = "server#{i}.example.com"
      node.vm.network "private_network", ip: "192.0.2.#{i}"
    end
  end

  config.vm.define "agent1" do |n1|
      n1.vm.hostname = "agent1.example.com"
      n1.vm.network "private_network", ip: "192.0.2.50"
  end
end