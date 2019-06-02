#!/bin/bash
# Shell script to format block device and mount it to /data and create fstab entry.
sudo mkfs -t ext4 /dev/xvdb
#sudo mkdir /data
sudo mount /dev/xvdb /opt
sudo echo /dev/xvdb  /opt ext4 defaults,nofail,noatime,nobootwait 0 2 >> /etc/fstab


sudo mkfs -t ext4 /dev/xvdc
sudo mkdir /data
sudo mount /dev/xvdc /data
sudo echo /dev/xvdc  /data ext4 defaults,nofail,noatime,nobootwait 0 2 >> /etc/fstab

#sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start


