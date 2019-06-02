#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install ntp -y
sudo apt-get remove awscli -y
sudo apt-get install ntp sysstat htop iotop strace python-pip python-setuptools -y
sudo pip install ujson
sudo pip install awscli
sudo ln -s /usr/local/bin/aws /usr/bin/aws
sudo sed -i 's/production/${env}/g' /etc/init/storm-supervisor.conf
sudo sed -i 's/production/${env}/g' /etc/init/storm-drpc.conf
sudo sed -i 's/production/${env}/g' /etc/init/storm-logviewer.conf
	
aws s3 cp --region ${region}  s3://my-${env}-info/storm-bootstrap/bootstrap_storm_${env}.sh /var/scripts/bootstrap_storm_${env}.sh && chmod +x /var/scripts/bootstrap_storm_${env}.sh
sleep 10
sudo /var/scripts/bootstrap_storm_${env}.sh
sleep 10
sudo chown -R root:root /opt/storm
chmod 755 /tmp/update_hosts_file.py
sleep 20
sudo python /tmp/update_hosts_file.py --env=${env} --region=${region} --domain=${domain} --private_domain=${private_domain} --public_hosted_zone_id=${zone_id_public} --private_hosted_zone_id=${zone_id_private}

sudo service storm-metrics start

#sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install
