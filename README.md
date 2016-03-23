# docker-swarm-ha-with-consul
Vagrant file with some stuff to run docker swarm high availabilty with consul.io


## Não é necessário para funcionar, mas obrigatório para produção

http://tech.paulcz.net/2016/01/secure-docker-with-tls/


## Comandos

Server
```
$ nohup consul agent -server -node=consulserver -bind 192.0.2.10 -client 0.0.0.0 -bootstrap-expect 1 -data-dir /tmp/consul -config-dir /etc/consul.d &> ~/consulserver.out&
$ echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry 192.0.2.20:5000"' >> /etc/default/docker
$ service docker restart
```


Router
```
$ wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_web_ui.zip -O ~/consul-ui.zip
$ unzip ~/consul-ui.zip -d ~/consul-ui
$ nohup consul agent -bind 192.0.2.20 -client 0.0.0.0 -data-dir /tmp/consul -ui-dir ~/consul-ui -join 192.0.2.10 &> ~/consulclient.out&
$ docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://192.0.2.20:8500
$ docker run -d -p 5000:5000 --restart=always --name registry -v /var/docker-registry-data:/var/lib/registry registry:2
```


Node
```
$ nohup consul agent -bind 192.0.2.30 -client 0.0.0.0 -data-dir /tmp/consul -join 192.0.2.10 &> ~/consulclient.out&
$ echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --insecure-registry 192.0.2.20:5000"' >> /etc/default/docker
$ service docker restart
$ docker run -d --name=registrator --net=host --volume=/var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://192.0.2.30:8500
$ docker run -d swarm join --advertise=192.0.2.30:2375 consul://192.0.2.30:8500
```

## Instalando Docker Swarm

No master
```
$ docker run -d -p 3376:3376 -t swarm manage -H 0.0.0.0:3376 consul://192.0.2.30:8500
```

Nos nós
```
$ docker run -d swarm join --advertise=192.0.2.30:2375 consul://192.0.2.30:8500
```



Executa app registrando um healthcheck no consul.io
```
$ docker run -d -p 5000:5000 --restart=always --name registry -e "SERVICE_5000_CHECK_HTTP=/" -e "SERVICE_5000_CHECK_INTERVAL=5" -v /var/docker-registry-data:/var/lib/registry registry:2
```

Serviços do registry
```
$ docker run -d --name redis -p 6379:6379 -e "SERVICE_NAME=db" -e "SERVICE_TAGS=master,backups" redis
$ curl localhost:8500/v1/catalog/services
$ curl localhost:8500/v1/catalog/service/db
```


## Controlando o docker swarm
Com este export não precisa mais ficar utilizando o `-H` em todos os comandos
```
$ #export DOCKER_HOST=192.0.2.10:3376
```

```
$ docker -H 192.0.2.10:3376 info
  Containers: 2
   Running: 2
   Paused: 0
   Stopped: 0
  Images: 3
  Server Version: swarm/1.1.3
  Role: primary
  Strategy: spread
  Filters: health, port, dependency, affinity, constraint
  Nodes: 1
   dockernode01: 192.0.2.30:2375
    └ Status: Healthy
    └ Containers: 2
    └ Reserved CPUs: 0 / 1
    └ Reserved Memory: 0 B / 514.5 MiB
    └ Labels: executiondriver=native-0.2, kernelversion=3.13.0-83-generic, operatingsystem=Ubuntu 14.04.4 LTS, storagedriver=devicemapper
    └ Error: (none)
    └ UpdatedAt: 2016-03-23T17:33:07Z
```






