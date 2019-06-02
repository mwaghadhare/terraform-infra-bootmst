#!/bin/bash
# Shell script to format block device and mount it to /data and create fstab entry.
sudo mkfs -t ext4 /dev/xvdb
sudo mkdir /data
sudo mount /dev/xvdb /data
sudo echo /dev/xvdb  /data ext4 defaults,nofail 0 2 >> /etc/fstab
