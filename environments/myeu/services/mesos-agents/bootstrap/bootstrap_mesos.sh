#!/bin/sh
#Author: Abhishek Amralkar

DIR=/tmp
cd $DIR
rm -rf $DIR/*


INSTANCE=`ec2metadata | grep instance-id | awk '{print $2}'`
HOSTNAME=`hostname -f`
SLACK_HOOK="https://hooks.slack.com/services/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"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
MODE=${MODE:-"deploy"}
#__OVERRIDE_MODE__

check_status(){
    status=$1
    file_type=$2
    if [ $1 -eq 0 ]; then
        logger "[INFO] ${file_type} downloaded from S3 on '$HOSTNAME' with instanceid '$INSTANCE'"
    else
        curl -X POST -H 'Content-type: application/json' --data '{"text":"$file_type file failed to download from S3 on '$HOSTNAME' with instanceid '$INSTANCE'"}' $SLACK_HOOK && return 0
    fi
}

get_tag_file_s3()
{
    if [ $MODE = "deploy" ]; then
        aws s3 cp s3://my-eu-info/mesos-bootstrap/update_tags.py $DIR --region $REGION
        check_status $? "Update tags"
    else
        aws s3 cp s3://my-eu-info/mesos-bootstrap/$MODE/update_tags.py $DIR --region $REGION
        check_status $? "Update tags mode=$MODE"
    fi

}


get_mesos_file_s3()
{
    if [ $MODE = "deploy" ]; then
        aws s3 cp s3://my-eu-info/mesos-bootstrap/mesos_components.sh $DIR --region $REGION
        check_status $? "Mesos component"
    else
        aws s3 cp s3://my-eu-info/mesos-bootstrap/$MODE/mesos_components.sh $DIR --region $REGION
        check_status $? "Mesos component mode=$MODE"
    fi
}


main()

{

get_tag_file_s3 || exit 1
get_mesos_file_s3 || exit 2
}

main
