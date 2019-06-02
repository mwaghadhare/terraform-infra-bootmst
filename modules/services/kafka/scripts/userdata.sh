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

sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install


sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start

#sudo aws s3 cp s3://my-testpad-info/kafka_metrics.tar.gz  --region ${var.region} /opt/
#tar -xzf /opt/kafka_metrics.tar.gz -C /opt/
#mv /opt/kafka_metrics/kafka_metrics.conf /etc/init/
#service kafka-metrics status
