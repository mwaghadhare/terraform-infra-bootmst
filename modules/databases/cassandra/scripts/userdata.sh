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

# Optimizations for files
sudo echo 'vm.max_map_count = 2000000' >> /etc/sysctl.conf
sudo echo 'fs.nr_open = 3000000' >> /etc/sysctl.conf

# Feel the city breakin' and everybody shakin'; And we're stayin' alive, stayin' alive; Ah, ha, ha, ha stayin' alive
# Prune dead connections if has been non-responsive for 3 mins; don't wait 2 hours (default)
sudo echo 'net.ipv4.tcp_keepalive_time = 180' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_keepalive_probes = 3' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_keepalive_intvl = 10' >> /etc/sysctl.conf

# Optimizations for network io; make TCP stack buffers large
sudo echo 'net.core.rmem_max = 16777216' >> /etc/sysctl.conf # 16 MB is reasonable I hope --PG
sudo echo 'net.core.wmem_max = 16777216' >> /etc/sysctl.conf
sudo echo 'net.core.rmem_default = 16777216' >> /etc/sysctl.conf
sudo echo 'net.core.wmem_default = 16777216' >> /etc/sysctl.conf
sudo echo 'net.core.optmem_max = 40960' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_rmem = 4096 87380 16777216' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_wmem = 4096 65536 16777216' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_mem = 16777216 16777216 16777216'  >> /etc/sysctl.conf

#sudo service cassandra restart
#sudo curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install && sudo bash install
#sudo curl -sSL https://dl.signalfx.com/collectd-install | bash -s W0RE9uDCngXcSZ7F9SzUZw --skip-time-sync-check

sudo sed -i 's/false/true/g' /etc/default/sysstat
sudo service sysstat start

sudo sysctl -p /etc/sysctl.conf
sudo service cassandra restart
