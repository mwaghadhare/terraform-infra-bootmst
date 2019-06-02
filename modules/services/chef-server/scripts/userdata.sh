#!/bin/bash
# Shell script to format block device and mount it to /data and create fstab entry.
#sudo mkfs -t ext4 /dev/xvdb
#sudo mkdir /data
#sudo mount /dev/xvdb /opt
#sudo echo /dev/xvdb  /opt ext4 defaults,nofail,noatime,nobootwait 0 2 >> /etc/fstab


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start
