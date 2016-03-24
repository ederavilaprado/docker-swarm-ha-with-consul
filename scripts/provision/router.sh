echo "Getting Consul WebUi..."
cd ~
wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip -O consul-ui.zip
unzip consul-ui.zip -d /home/vagrant/consul-ui
rm consul-ui.zip
chown -R vagrant:vagrant /home/vagrant/consul-ui

echo "Starting Consul client..."
nohup consul agent -bind 192.0.2.20 -client 0.0.0.0 -data-dir /tmp/consul -ui-dir /home/vagrant/consul-ui -join 192.0.2.10 &> /home/vagrant/consulclient.out&

echo "Starting Docker Registrator..."
docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://192.0.2.20:8500

echo "Starting Docker RegistryV2..."
docker run -d -p 5000:5000 --restart=always --name registry -v /var/docker-registry-data:/var/lib/registry registry:2