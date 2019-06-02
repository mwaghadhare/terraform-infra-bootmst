import boto3
route53 = boto3.client('route53')
ec2 = boto3.resource('ec2')
compute = boto3.client('ec2')
def lambda_handler(event, context):
      id=event['detail']['instance-id']
      ec2client = boto3.client('ec2')
      response=ec2client.describe_instances(InstanceIds=[id])

      for i in response['Reservations'][0]['Instances'][0]['Tags']:
          if i['Key']=='Name':
              hostname=i['Value']
              print(hostname)
          if i['Key']=='publicDNS':
              publicdns=i['Value']
              print(publicdns)

          if i['Key']=='Private_Name':
              Private_Name=i['Value']
              print(Private_Name)
          if i['Key']=='privateDNS':
              privateDNS=i['Value']
              print(privateDNS)

      route53.change_resource_record_sets(
                       HostedZoneId="${var.zone_id_public}",
                       ChangeBatch={
                           "Comment": "Updated by Lambda DNS",
                           "Changes": [
                               {
                                   "Action": "DELETE",
                                   "ResourceRecordSet": {
                                       "Name": hostname ,
                                       "Type": "CNAME",
                                       "TTL": 60,
                                       "ResourceRecords": [
                                           {
                                               "Value": publicdns
                                           },
                                       ]
                                   }
                               },
                           ]
                       }
                   )

      route53.change_resource_record_sets(
                       HostedZoneId="${var.zone_id_private}",
                       ChangeBatch={
                           "Comment": "Updated by Lambda DNS",
                           "Changes": [
                               {
                                   "Action": "DELETE",
                                   "ResourceRecordSet": {
                                       "Name": Private_Name ,
                                       "Type": "CNAME",
                                       "TTL": 60,
                                       "ResourceRecords": [
                                           {
                                               "Value": privateDNS
                                           },
                                       ]
                                   }
                               },
                           ]
                       }
                   )
  
