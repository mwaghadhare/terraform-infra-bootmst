#!/bin/bash
# Shell script to format block device and mount it to /data and create fstab entry.
sudo apt-get update
sudo apt-get install git awscli redis-tools -y
cd /home/ubuntu
sudo aws s3 cp s3://my-${env}-assets/redis-proxies/predixy-0.0.21.tgz .
sudo aws s3 cp s3://my-${env}-assets/redis-proxies/corvus-0.2.7.tar.bz2 .
sudo tar xzf predixy-0.0.21.tgz . && sudo ln -s /home/ubuntu/predixy-0.0.21 /home/ubuntu/predixy 
sudo tar xvjf corvus-0.2.7.tar.bz2 . && sudo ln -s /home/ubuntu/corvus-0.2.7 /home/ubuntu/corvus
sudo apt-get install build-essential python-ujson python-thrift python-setuptools autoconf

#sudo sed -i 's/production/${env}/g' /etc/init/storm-nimbus.conf
#sudo sed -i 's/production/${env}/g' /etc/init/storm-ui.conf
#sudo sed -i 's/production/${env}/g' /etc/init/storm-drpc.conf


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start
