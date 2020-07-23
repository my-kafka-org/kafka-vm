#!/bin/bash

function set_hostname()  {
   sudo yum install -y wget
   local_ip=`wget -q -O - http://169.254.169.254/latest/meta-data/local-ipv4`
   HOSTNAME=thiru_nginx-$local_ip
   hostname $HOSTNAME
   echo "HOSTNAME=$HOSTNAME" > /etc/hostname
   echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network
   hostnamectl set-hostname $HOSTNAME --static
   echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
}

function install_nginx() {
    sudo yum update
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum install -y epel-release
    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
}

function install_kafka {
sudo yum install -y java-1.8.0-openjdk
sudo wget https://apachemirror.sg.wuchna.com/kafka/2.5.0/kafka_2.13-2.5.0.tgz
sudo gunzip kafka_2.13-2.5.0.tgz
sudo tar -xvf kafka_2.13-2.5.0.tar
sudo mkdir -p  /kafka_2.13-2.5.0/data/zookeeper
path-txt=`export PATH=/kafka_2.13-2.5.0/bin:\$PATH` 
$path-txt >> ~/.bashrc
}

set_hostname
install_nginx
install_kafka