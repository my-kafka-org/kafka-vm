#!/bin/bash

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
sudo mkdir -p  /root/kafka_2.13-2.5.0/data/zookeeper
sudo pathtxt="export PATH=/root/kafka_2.13-2.5.0/bin:\$PATH"
sudo echo $pathtxt >> ~/.bashrc
}

install_nginx
install_kafka