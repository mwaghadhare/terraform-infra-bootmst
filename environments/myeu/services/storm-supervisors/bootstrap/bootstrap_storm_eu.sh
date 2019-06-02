#!/bin/sh
#Author: Abhishek Amralkar

DIR=/tmp
cd $DIR
rm -rf $DIR/*


INSTANCE=`ec2metadata | grep instance-id | awk '{print $2}'`
HOSTNAME=`hostname -f`
SLACK_HOOK="https://hooks.slack.com/services/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"


get_file_s3()
{
    aws s3 cp s3://my-eu-info/storm-bootstrap/update_hosts_file.py $DIR --region eu-central-1
       if [ $? -eq 0 ]; then
            logger "[INFO] Update host file downloaded from S3 on '$HOSTNAME' with instanceid '$INSTANCE'"
        else
            curl -X POST -H 'Content-type: application/json' --data '{"text":"Update host file failed to download from S3 on '$HOSTNAME' with instanceid '$INSTANCE'"}' $SLACK_HOOK && return 0
      fi
}

configure_storm_metrics()
{
  aws s3 --region eu-central-1 cp s3://my-eu-assets/storm_metrics/storm_metrics.tar.gz /opt/
  mkdir -p /opt/storm_metrics && tar -zxvf /opt/storm_metrics.tar.gz -C /opt/
}

update_nodejs()
{
  sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
  sudo  mv /usr/local/bin/node /usr/local/bin/node-old && mv /usr/local/bin/npm /usr/local/bin/npm-old
  sudo apt-get install nodejs -y
}

main()

{

get_file_s3 || exit 1
configure_storm_metrics || exit 2
update_nodejs || exit 3
}

main
