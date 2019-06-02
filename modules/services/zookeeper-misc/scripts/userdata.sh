#!/bin/bash
# Shell script to format block device and mount it to /data and create fstab entry.
sudo mkfs -t ext4 /dev/nvme1n1
#sudo mkdir /data
sudo mount /dev/nvme1n1 /opt
sudo echo /dev/nvme1n1  /opt ext4 defaults,nofail,noatime,nobootwait 0 2 >> /etc/fstab


sudo mkfs -t ext4 /dev/nvme2n1
sudo mkdir /data
sudo mount /dev/nvme2n1 /data
sudo echo /dev/nvme2n1  /data ext4 defaults,nofail,noatime,nobootwait 0 2 >> /etc/fstab


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start

#sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install
