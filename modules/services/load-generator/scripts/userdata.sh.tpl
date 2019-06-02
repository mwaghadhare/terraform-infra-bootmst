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

sudo apt-get install jq python-pip zip -y
sudo pip install virtualenv

sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start

sudo pip install awscli

sudo aws s3 cp s3://my-${env}-info/binaries/kafkaclient  --region ${region} /opt/
sudo aws s3 cp s3://my-${env}-info/binaries/kafkapoke  --region ${region} /opt/
sudo aws s3 cp s3://my-${env}-info/binaries/s3archiveclient --region ${region} /opt/

sudo chmod a+x /opt/kafkaclient
sudo chmod a+x /opt/s3archiveclient
sudo chmod a+x /opt/kafkapoke

sudo aws s3 cp s3://my-${env}-assets/services/my-ap/apsim2-latest.zip /opt --region ${region}
sudo unzip /opt/apsim2-latest.zip -d /opt/apsim && sudo rm /opt/apsim2-latest.zip
sudo aws s3 cp s3://my-${env}-info/keys/ep-terminator/ep-terminator-${env}-cert.pem /opt/apsim/cacert-${env}.pem --region ${region}
sudo cp /opt/apsim/cacert-${env}.pem /opt/apsim/cacert.pem
sudo cp /opt/apsim/cloud-${env}.ini /opt/apsim/cloud.ini

sudo aws s3 cp s3://my-${env}-assets/services/my-ap/apsim-replay-latest.zip /opt --region ${region}
sudo unzip /opt/apsim-replay-latest.zip -d /opt/apsim-replay && sudo rm /opt/apsim-replay-latest.zip
sudo aws s3 cp s3://my-${env}-assets/services/my-pace/pacesim-replay-latest.zip /opt --region ${region}
sudo unzip /opt/pacesim-replay-latest.zip -d /opt/pacesim-replay && sudo rm /opt/pacesim-replay-latest.zip
sudo aws s3 cp s3://my-${env}-assets/services/mobile-sim/mobile-sim-latest.zip /opt --region ${region}
sudo unzip /opt/mobile-sim-latest.zip -d /opt/mobilesim && sudo rm /opt/mobile-sim-latest.zip
sudo aws s3 cp s3://my-${env}-assets/services/le-wc-asset-sim/le-wc-asset-sim-latest.zip /opt --region ${region}
sudo unzip /opt/le-wc-asset-sim-latest.zip -d /opt/le-wc-asset-sim && sudo rm /opt/le-wc-asset-sim-latest.zip
sudo aws s3 cp s3://my-${env}-assets/services/my_load_test_framework/my_load_test_framework-latest.zip /opt --region ${region}
sudo unzip /opt/my_load_test_framework-latest.zip -d /opt/my_load_test_framework && sudo rm /opt/my_load_test_framework-latest.zip

sudo wget http://mirrors.ocf.berkeley.edu/apache/kafka/1.0.0/kafka_2.12-1.0.0.tgz -O /opt/kafka_2.12-1.0.0.tgz
sudo tar -xvf /opt/kafka_2.12-1.0.0.tgz && sudo rm /opt/kafka_2.12-1.0.0.tgz
sudo mv /opt/kafka_2.12-1.0.0 /opt/kafka
