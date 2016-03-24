echo "Starting Consul Master..."
nohup consul agent -server -node=consulserver -bind 192.0.2.10 -client 0.0.0.0 -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /etc/consul.d &> /home/vagrant/consulserver.out&

echo "Updating Docker init configs"
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry 192.0.2.20:5000"' >> /etc/default/docker
service docker restart

echo "Waiting 5 seconds to full restart the docker daemon"
sleep 5

echo "Running Docker Swarm Master..."
docker run -d -p 3376:3376 -t swarm manage -H 0.0.0.0:3376 consul://192.0.2.10:8500