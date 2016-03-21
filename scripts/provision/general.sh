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


echo Installing Docker...
apt-get install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo  "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-cache policy docker-engine

apt-get update
apt-get install linux-image-extra-$(uname -r)

apt-get install apparmor

apt-get update

apt-get install docker-engine

echo "Init Docker daemon..."
service docker start



