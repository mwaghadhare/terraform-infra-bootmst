output "zookeeper_sg_id" {
  value = "${aws_security_group.zookeeper_sg.id}"
}

output "bastion_sg_id" {
  value = "${aws_security_group.bastion_sg.id}"
}

output "kafka_sg_id" {
  value = "${aws_security_group.kafka_sg.id}"
}

output "cassandra_sg_id" {
  value = "${aws_security_group.cassandra_sg.id}"
}

output "mesos-master_sg_id" {
  value = "${aws_security_group.mesos-master_sg.id}"
}

output "mesos-agents_sg_id" {
  value = "${aws_security_group.mesos-agents_sg.id}"
}

output "nimbus_sg_id" {
  value = "${aws_security_group.nimbus_sg.id}"
}

output "storm-supervisors_sg_id" {
  value = "${aws_security_group.storm-supervisors_sg.id}"
}

output "redis_sg_id" {
  value = "${aws_security_group.redis_sg.id}"
}

output "papi_rds_sg_id" {
  value = "${aws_security_group.papi_rds_sg.id}"
}

output "pdb_sg_id" {
  value = "${aws_security_group.pdb_sg.id}"
}

output "service_elb_sg_id" {
  value = "${aws_security_group.service_elb_sg.id}"
}

output "client-terminator_elb_sg_id" {
  value = "${aws_security_group.client-terminator_elb_sg.id}"
}

output "ep-terminator_elb_sg_id" {
  value = "${aws_security_group.ep-terminator_elb_sg.id}"
}

output "kong_elb_sg_id" {
  value = "${aws_security_group.kong_elb_sg.id}"
}

output "papi_elb_sg_id" {
  value = "${aws_security_group.papi_elb_sg.id}"
}

output "client-terminator_sg_id" {
  value = "${aws_security_group.client-terminator_sg.id}"
}

output "ep-terminator_sg_id" {
  value = "${aws_security_group.ep-terminator_sg.id}"
}

output "kong_sg_id" {
  value = "${aws_security_group.kong_sg.id}"
}

output "traefik_sg_id" {
  value = "${aws_security_group.traefik_sg.id}"
}

output "tdb_rds_sg_id" {
  value = "${aws_security_group.tdb_rds_sg.id}"
}

output "monitor_sg_id" {
  value = "${aws_security_group.monitor_sg.id}"
}

output "kong_rds_sg_id" {
  value = "${aws_security_group.kong_rds_sg.id}"
}

output "graphite_sg_id" {
  value = "${aws_security_group.graphite_sg.id}"
}

output "openvpn_sg_id" {
  value = "${aws_security_group.openvpn_sg.id}"
}

output "zone_rds_sg_id" {
  value = "${aws_security_group.zone_rds_sg.id}"
}

output "elasticsearch_sg_id" {
  value = "${aws_security_group.elasticsearch_sg.id}"
}

output "jenkins_sg_id" {
  value = "${aws_security_group.jenkins_sg.id}"
}

output "influxdb_sg_id" {
  value = "${aws_security_group.influxdb_sg.id}"
}

output "load-generator_sg_id" {
  value = "${aws_security_group.load-generator_sg.id}"
}

output "openvpngate_rds_sg_id" {
  value = "${aws_security_group.openvpngate_rds_sg.id}"
}

output "consul_sg_id" {
  value = "${aws_security_group.consul_sg.id}"
}

output "chef-server_sg_id" {
  value = "${aws_security_group.chef-server_sg.id}"
}

output "praxis_sg_id" {
  value = "${aws_security_group.praxis_sg.id}"
}

output "ap-qa_sg_id" {
  value = "${aws_security_group.ap-qa_sg.id}"
}

output "predixy_sg_id" {
  value = "${aws_security_group.predixy_sg.id}"
}

