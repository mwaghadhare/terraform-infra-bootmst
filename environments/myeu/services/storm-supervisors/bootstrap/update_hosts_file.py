import argparse
import sys
import time
import json
import os
import binascii
import subprocess
from random import randint

# sample record. Change Value and Name fields
route53_rec = {
  "Comment": "optional comment about the changes in this change batch request",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "DNS domain name",
        "Type": "CNAME",
        "TTL": 60,
        "ResourceRecords": [
          {
            "Value": "applicable value for the record type"
          },
        ],
      }
    },
  ]
}

def write_config_file(config_file, NUM_SLOTS, env, domain):
    with open(config_file, 'w') as fd:
        fd.write('supervisor.slots.ports:\n')
        for x in range(6700, 6700+NUM_SLOTS):
            fd.write('  - {0}\n'.format(x))
        fd.write('\n')
        fd.write('storm.local.dir: "/opt/storm/storm-data"')
        fd.write('\n')
        fd.write('java.library.path: "/opt/storm/apache-storm-1.0.2/lib/"')
        fd.write('\n')
        fd.write('supervisor.childopts: "-Xmx1024m -Djava.net.preferIPv4Stack=true"')
        fd.write('\n')
        fd.write('nimbus.childopts: "-Xmx2048m  -Djava.net.preferIPv4Stack=true"')
        fd.write('\n')
        fd.write('worker.childopts: "-Xmx1024m -Djava.net.preferIPv4Stack=true -XX:+PrintGCTimeStamps -verbose:gc -Xloggc:/opt/storm/apache-storm-1.0.2/logs/gc-storm-worker-%ID%.log -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=1%ID%"')
        fd.write('\n')
        fd.write('\n')
        fd.write('supervisor.childopts: "-Xmx1024m -Djava.net.preferIPv4Stack=true -XX:+PrintGCTimeStamps -verbose:gc -Xloggc:/opt/storm/apache-storm-1.0.2/logs/gc-storm-worker-%p.log -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=9999"')
        fd.write('\n')
        fd.write('storm.zookeeper.servers:\n')
        for z in range(3):
            fd.write('  - "zookeeper-00{0}-{1}.{2}"\n'.format(z, env, private_domain))
        fd.write('\n')
        fd.write('nimbus.host:  "nimbus-000-{0}.{1}"'.format(env, private_domain))


def get_private_this_host():
    os.system('curl -s http://169.254.169.254/latest/meta-data/local-ipv4 > pvt_ip')
    with open('pvt_ip', 'r') as fd:
        return fd.readline().strip()

def get_num_cpus_this_host():
    os.system('lscpu | grep CPU\(s\): > cpu_info')
    with open('cpu_info', 'r') as fd:
        for line in fd:
            if 'NUMA' not in line:
                return int(line.split()[-1])

def get_memory_in_gb_this_host():
    os.system("dmidecode -t 17 | grep 'Size.*MB' | awk '{s+=$2} END {print s / 1024}' > memory_info")
    with open('memory_info', 'r') as fd:
        return float(fd.readline().strip())

def get_instance_id_this_host():
    os.system('curl -s http://169.254.169.254/latest/meta-data/instance-id > instance_id')
    with open('instance_id', 'r') as fd:
        return fd.readline().strip()

def get_public_dns_name_this_host():
    os.system('curl -s http://169.254.169.254/latest/meta-data/public-hostname > pub_dns_name')
    with open('pub_dns_name', 'r') as fd:
        return fd.readline().strip()

def get_private_dns_name_this_host():
    os.system('curl -s http://169.254.169.254/latest/meta-data/local-hostname > pvt_dns_name')
    with open('pvt_dns_name', 'r') as fd:
        return fd.readline().strip()

def storm_services(op_type):
    os.system('sudo service storm-supervisor {0}'.format(op_type))
    os.system('sudo service storm-drpc {0}'.format(op_type))
    os.system('sudo service storm-logviewer {0}'.format(op_type))

mem_per_slot = 1.33 # in GBs based on m4.xlarge having 12 workers with 16GB total memory
cpus_per_slot = 1 # based on m4.xlarge having 4 CPUs with 12 workers

def parse_args():
    parser = argparse.ArgumentParser(description='User data for storm hosts')
    parser.add_argument('--env', action="store", required=True)
    parser.add_argument('--region', action="store", required=True)
    parser.add_argument('--domain', action="store", required=True)
    parser.add_argument('--private_domain', action="store", required=True)
    parser.add_argument('--public_hosted_zone_id', action="store", required=True)
    parser.add_argument('--private_hosted_zone_id', action="store", required=True)
    return parser.parse_args()


if __name__ == '__main__':
    cli_args = parse_args()
    hostname = None
    fname = '/etc/hosts'
    env = cli_args.env
    region = cli_args.region
    domain = cli_args.domain
    private_domain = cli_args.private_domain
    private_hosted_zone_id = cli_args.private_hosted_zone_id
    public_hosted_zone_id = cli_args.public_hosted_zone_id
    log_fd = open('user_data_spot.log', 'w')
    storm_services('stop')
    os.system('rm -rf  /opt/storm/storm-data')
    os.system('cd /opt/marvis && git pull origin HEAD')
    os.system('pip install -r /opt/marvis/storm/py/requirements.txt')
    org_pvt_ip = get_private_this_host()
    log_fd.write('Original IP:{0}\n'.format(org_pvt_ip))
    num_cpus = get_num_cpus_this_host()
    mem_ing_gb = get_memory_in_gb_this_host()
    NUM_SLOTS = int(min(
        num_cpus/cpus_per_slot,
        mem_ing_gb/mem_per_slot
    ))
    write_config_file('/opt/storm/apache-storm-1.0.2/conf/storm.yaml', NUM_SLOTS, env, domain)

    os.system('cp /etc/hosts hosts.backup')
    with open('hosts-updated'.format(fname), 'w') as updated_fd:
        with open(fname, "r") as fd:
            for line in fd:
                updated_line = line
                if 'storm-' in line:
                    ami_pvt_ip, full_host, partial_host = line.split()
                    pvt_ip_with_dashes = '-'.join(org_pvt_ip.split('.'))
                    # get 4 bytes of randomness
                    rand_hash = binascii.b2a_hex(os.urandom(4))
                    hostname = 'storm-{0}-{1}.{2}.{3}'.format(pvt_ip_with_dashes, rand_hash, env, domain)
                    private_hostname = 'storm-{0}-{1}-{2}.{3}'.format(pvt_ip_with_dashes, rand_hash, env, private_domain)
                    log_fd.write('changing line:{0}\n'.format(line))
                    updated_line = '{0} {1} storm-{2}-{3}\n'.format(
                        org_pvt_ip,
                        hostname,
                        pvt_ip_with_dashes,
                        env,
                    )
                updated_fd.write(updated_line)

    os.system('hostname {0}'.format(hostname))
    os.system('mv hosts-updated /etc/hosts')

    dns_name = get_public_dns_name_this_host()
    route53_rec["Changes"][0]['ResourceRecordSet']["ResourceRecords"][0]['Value'] = dns_name
    route53_rec["Changes"][0]['ResourceRecordSet']["Name"] = "{0}.".format(hostname)

    with open('route_53_entry.json', 'w') as fd:
        fd.write(json.dumps(route53_rec))
        print(json.dumps(route53_rec))

    private_dns_name = get_private_dns_name_this_host()
    route53_rec["Changes"][0]['ResourceRecordSet']["ResourceRecords"][0]['Value'] = private_dns_name
    route53_rec["Changes"][0]['ResourceRecordSet']["Name"] = "{0}.".format(private_hostname)

    with open('private_route_53_entry.json', 'w') as fd:
        fd.write(json.dumps(route53_rec))
        print(json.dumps(route53_rec))

    instance_id = get_instance_id_this_host()
    log_fd.write('instance-id:{0}\n'.format(instance_id))

    def CreateRoute53():
        cmd=["aws route53 change-resource-record-sets --hosted-zone-id {0} --change-batch file://route_53_entry.json".format(public_hosted_zone_id)]
        res = subprocess.call(cmd, shell=True)
        if res == 0:
            print("Public Entry for Route53 Created Successfully")
            return
        else:
            print("Public Entry For Route53 Failed")
            time.sleep(randint(0, 15))
            CreateRoute53()

    CreateRoute53()

    def CreatePrivateRoute53():
        cmd=["aws route53 change-resource-record-sets --hosted-zone-id {0} --change-batch file://private_route_53_entry.json".format(private_hosted_zone_id)]
        res = subprocess.call(cmd, shell=True)
        if res == 0:
            print("Private Entry for Route53 Created Successfully")
            return
        else:
            print("Private Entry For Route53 Failed")
            time.sleep(randint(0, 15))
            CreatePrivateRoute53()

    CreatePrivateRoute53()

    def HostTag():
        cmd = 'aws ec2 create-tags --region {0} --resources {1} --tags Key=Name,Value={2}'.format(
            region,
            instance_id,
            hostname,
        )
        res = subprocess.call(cmd,shell=True)
        if res == 0:
            print("Tags for hostname Created Successfully")
            return
        else:
            print("Trying Again")
            time.sleep(5)
            HostTag()

    HostTag()

    def PrivateHostTag():
        cmd = 'aws ec2 create-tags --region {0} --resources {1} --tags Key=PrivateName,Value={2}'.format(
            region,
            instance_id,
            private_hostname,
        )
        res = subprocess.call(cmd,shell=True)
        if res == 0:
            print("Tags for Private hostname Created Successfully")
            return
        else:
            print("Trying Again")
            time.sleep(5)
            PrivateHostTag()

    PrivateHostTag()

    def publicDNS():
        cmd = 'aws ec2 create-tags --region {0} --resources {1} --tags Key=publicDNS,Value={2}'.format(
            region,
            instance_id,
            dns_name,
        )
        res = subprocess.call(cmd,shell=True)
        if res == 0:
            print("Tags for PublicDNS Created Successfully")
            return
        else:
            print("Trying Again")
            time.sleep(5)
            publicDNS()

    publicDNS()

    def ServiceTag():
        cmd = 'aws ec2 create-tags --region {0} --resources {1} --tags Key=service,Value=storm'.format(
            region,
            instance_id,
        )
        res = subprocess.call(cmd,shell=True)
        if res == 0:
            print("Tags for Service Storm Created Successfully")
            return
        else:
            print("Trying Again")
            time.sleep(5)
            ServiceTag()

    ServiceTag()


    def privateDNS():
        cmd = 'aws ec2 create-tags --region {0} --resources {1} --tags Key=privateDNS,Value={2}'.format(
            region,
            instance_id,
            private_dns_name,
        )
        res = subprocess.call(cmd,shell=True)
        if res == 0:
            print("Tags for PrivateDNS Created Successfully")
            return
        else:
            print("Trying Again")
            time.sleep(5)
            privateDNS()

    privateDNS()

    # just sleep for a bit for things to settle down...
    time.sleep(5)
    storm_services('start')
    instance_id = get_instance_id_this_host()
    log_fd.write('instance-id:{0}\n'.format(instance_id))
