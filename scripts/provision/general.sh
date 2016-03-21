echo Installing dependencies...
apt-get update
apt-get install -y unzip curl htop jq

echo Fetching Consul...
cd ~
wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip -O consul.zip

echo Installing Consul...
unzip consul.zip
chmod +x consul
mv consul /usr/bin/consul

mkdir /etc/consul.d
chmod a+w /etc/consul.d

