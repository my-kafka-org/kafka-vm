#!/bin/bash

function install_nginx() {
#    sudo yum update -y
    sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum install -y epel-release
#    sudo yum update -y
    sudo yum install nginx -y
    sudo systemctl start nginx
    sudo systemctl enable nginx
}

function install_kafka {
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y wget
sudo wget https://apachemirror.sg.wuchna.com/kafka/2.5.0/kafka_2.13-2.5.0.tgz
sudo gunzip kafka_2.13-2.5.0.tgz
sudo tar -xvf kafka_2.13-2.5.0.tar
sudo mkdir -p  /kafka_2.13-2.5.0/data/zookeeper
sudo mkdir -p  /kafka_2.13-2.5.0/data/kafka
sudo echo "export PATH=/kafka_2.13-2.5.0/bin:\$PATH" >> ~/.bashrc
sudo gsutil cp gs://kafka-config-san/server.properties /kafka_2.13-2.5.0/config
sudo gsutil cp gs://kafka-config-san/zookeeper.properties /kafka_2.13-2.5.0/config
sudo /kafka_2.13-2.5.0/bin/zookeeper-server-start.sh /kafka_2.13-2.5.0/config/zookeeper.properties &
sudo /kafka_2.13-2.5.0/bin/kafka-server-start.sh /kafka_2.13-2.5.0/config/server.properties &
}
install_nginx
install_kafka