#!/bin/bash
export MODE=deploy
aws s3 cp --region ${var.region}  s3://my-${var.env}-info/mesos-bootstrap/bootstrap_mesos.sh /var/scripts/bootstrap_mesos.sh && chmod +x /var/scripts/bootstrap_mesos.sh
/var/scripts/bootstrap_mesos.sh
sleep 10
chmod 755 /tmp/update_tags.py
sleep 10
python /tmp/update_tags.py --env=${var.env} --region=${var.region} --domain=${var.domain} --hosted_zone_id=${var.zone_id_public}
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
