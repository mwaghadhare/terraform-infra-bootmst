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



# All important package installation for performance


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start
