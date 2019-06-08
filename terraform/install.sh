#!/bin/bash

# this script will install docker and pull down jenkins container on CentOS 7 

# install docker
yum remove docker docker-common docker-selinux docker-engine
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io

#start docker
systemctl enable docker
systemctl start docker

# install jenkins
groupadd --system jenkins
useradd -s /sbin/nologin --system -g jenkins jenkins
usermod -a -G docker jenkins
usermod -a -G docker centos
docker pull jenkins/jenkins:lts
mkdir /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home

# run jenkins image
docker run -p 8080:8080 -p 50000:50000 -v /var/jenkins_home:/var/jenkins_home -d --name jenkins jenkins/jenkins:lts
cat /var/jenkins_home/secrets/initialAdminPassword
