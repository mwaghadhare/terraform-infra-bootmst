#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install ntp -y
sudo apt-get remove awscli -y
sudo pip install awscli
sudo apt-get install ntp sysstat htop iotop strace python-pip python-setuptools -y
sudo pip install ujson
sudo ln -s /usr/local/bin/aws /usr/bin/aws
export MODE=deploy
aws s3 cp --region ${region}  s3://my-${env}-info/mesos-bootstrap/bootstrap_mesos.sh /var/scripts/bootstrap_mesos.sh && chmod +x /var/scripts/bootstrap_mesos.sh
/var/scripts/bootstrap_mesos.sh
sleep 10
chmod 755 /tmp/update_tags.py
sleep 10
python /tmp/update_tags.py --env=${env} --region=${region} --domain=${domain} --private_domain=${private_domain} --public_hosted_zone_id=${zone_id_public} --private_hosted_zone_id=${zone_id_private}
sleep 5
chmod 755 /tmp/mesos_components.sh
/tmp/mesos_components.sh
sleep 10
sudo rm -rf /etc/init/mesos-slave.override
sudo rm -rf /etc/init/consul.override
sudo rm -rf /etc/init/docker.override
sudo mv /etc/init/mesos-slave.conf_ctmpl /etc/init/mesos-slave.conf
sudo service docker restart
sudo service mesos-slave start
#sudo mv /etc/init/mesos-metrics.conf_ctmpl /etc/init/mesos-metrics.conf
sudo service mesos-metrics start
sudo service cadvisor restart
sudo service auditd restart
sudo service sysstat restart
sudo cp /etc/resolvconf/resolv.conf.d/head.bkup /etc/resolvconf/resolv.conf.d/head
sudo resolvconf -u
sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install
