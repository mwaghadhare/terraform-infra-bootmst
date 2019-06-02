#!/bin/bash
#Desciption : After the script run, docker service is required to be started, before starting mesos

INSTANCE=`ec2metadata | grep instance-id | awk '{print $2}'`
HOSTNAME=`hostname -f`
SLACK_HOOK="https://hooks.slack.com/services/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"




create_log_dir()
{

if [[ ! -e /data/log ]]; then
     mkdir /data/log
       if [ $? -eq 0 ]; then
            logger "[INFO] Data Mesos Directory created $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Mesos Data Log Directory creation $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
fi

}

create_logs_dir()
{
if [[ ! -e /data/logs ]]; then
     mkdir /data/logs
        if [ $? -eq 0 ]; then
            logger "[INFO] Data Logs Directory created $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Data Logs Directory creation $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
fi
}

create_mesos_dir()
{

if [[ ! -e /data/mesos ]]; then
     mkdir /data/mesos
       if [ $? -eq 0 ]; then
            logger "[INFO] Data Mesos Directory created $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Mesos Data Directory creation $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
fi

}

create_docker_dir()
{

if [[ ! -e /data/docker ]]; then
     mkdir /data/docker
        if [ $? -eq 0 ]; then
            logger "[INFO] Data Docker Directory created $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Data Docker Directory creation $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
fi
}

create_dockercleaner_dir()
{

if [[ ! -e /data/logs/dockercleaner ]]; then
     mkdir /data/logs/dockercleaner
if [ $? -eq 0 ]; then
            logger "[INFO] Data Docker Cleaner Directory created $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Data Docker Cleaner Directory creation $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
fi

}


IP=`hostname -i`
PUBLIC_HOSTNAME=`curl http://169.254.169.254/latest/meta-data/public-hostname`

replace_consul_ip()
{

  sed -i "s/\"bind_addr\":.*/\"bind_addr\": \"${IP}\",/" /etc/consul/consul.json &&  sed -i "s/\"node_name\":.*/\"node_name\": \"${PUBLIC_HOSTNAME}\",/" /etc/consul/consul.json && return 0
     if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI replaced Consul IP $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI problem in replacing Consul IP $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

replace_mesos_slave_ip()
{

  sed  -i "s/--ip=.*/--ip=${IP} \\\/" /etc/mesos-chef/mesos-slave && return 0
      if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI replace of mesos slave IP $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI problem in replacing Mesos Slave IP $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

restart_docker()
{

  service docker restart && return 0
if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI Docker started on $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Docker start $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

restart_mesos_slave()
{

  service mesos-slave restart && return 0
if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI mesos slave started on $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Mesos Slave start $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

restart_consul()
{

  service consul restart && return 0
if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI Consul started on $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with Consul start $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

restart_awslogs()
{

  service awslogs restart && return 0
if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI awslogs started on $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with awslogs start $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

restart_hostname()
{

  service hostname restart && return 0
if [ $? -eq 0 ]; then
            logger "[INFO] Mesos AMI hostname started on $HOSTNAME with instanceid $INSTANCE"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Mesos AMI Issue with hostname start $HOSTNAME with instanceid $INSTANCE"}' $SLACK_HOOK && return 0
      fi
}

configure_mesos_metrics()
{
  aws s3 --region=us-east-1 cp s3://my-eu-assets/mesos_metrics/mesos_metrics.tar.gz /opt/
  mkdir -p /opt/mesos_metrics && tar -zxvf /opt/mesos_metrics.tar.gz -C /opt/
}

main()
{

#stop_mesos_slave || exit 1
create_logs_dir || exit 2
create_mesos_dir || exit 3
replace_consul_ip || exit 4
create_docker_dir || exit 5
replace_mesos_slave_ip || exit 6
create_log_dir || exit 7
create_dockercleaner_dir || exit 8
restart_docker || exit 9
restart_mesos_slave ||  exit 10
restart_consul || exit 11
restart_awslogs || exit 12
restart_hostname || exit 13
configure_mesos_metrics || exit 14

}


main
