echo "Starting Consul client..."
nohup consul agent -bind 192.0.2.30 -client 0.0.0.0 -data-dir /tmp/consul -join 192.0.2.10 &> /home/vagrant/consulclient.out&

echo "Updating Docker init configs"
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry 192.0.2.20:5000"' >> /etc/default/docker
service docker restart

echo "Waiting 5 seconds to full restart the docker daemon"
sleep 5

echo "Starting Docker Registrator..."
docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://192.0.2.30:8500

echo "Running Docker Swarm Client..."
docker run -d swarm join --advertise=192.0.2.30:2375 consul://192.0.2.30:8500