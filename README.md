# docker-swarm-ha-with-consul

Vagrant file with some stuff to run docker swarm high availabilty with consul.io

## How to

```bash
$ wget https://github.com/ederavilaprado/docker-swarm-ha-with-consul.git
$ cd docker-swarm-ha-with-consul
$ vagrant up
```

## General

**Starting...**

With the `registrator` running, to run and register a container with healthcheck.
More info: https://github.com/gliderlabs/registrator
```
$ docker run -d -p 5000:5000 --restart=always --name registry -e "SERVICE_5000_CHECK_HTTP=/" -e "SERVICE_5000_CHECK_INTERVAL=5" -v /var/docker-registry-data:/var/lib/registry registry:2
```


**Controling the Docker Swarm**
```bash
$ export DOCKER_HOST=192.0.2.10:3376
$ docker info
# ou
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

## Installing "GO"

Needs to add this to the scripts

```bash
$ cd ~
$ wget https://storage.googleapis.com/golang/go1.6.linux-amd64.tar.gz
$ tar -xvf go1.6.linux-amd64.tar.gz
$ mv go /usr/local/
$ rm go1.6.linux-amd64.tar.gz
$ chown -R vagrant:vagrant /usr/local/go
$ mkdir -p /home/vagrant/workspace/go/src
echo "export PATH=\$PATH:/usr/local/go/bin" >> /home/vagrant/.profile
echo "export GOPATH=\$HOME/workspace/go" >> /home/vagrant/.profile
```


## Creating build

**Options to test**

- Buildstep by progrium (https://github.com/progrium/buildstep)
- https://www.packer.io
- https://github.com/gliderlabs/herokuish
- https://blog.docker.com/2013/05/heroku-buildpacks-on-docker/
- http://blog.tutum.co/2014/04/10/creating-a-docker-image-from-your-code/
- https://github.com/openshift/source-to-image














