output "vpc_id" {
  value = "${module.eu_vpc.vpc_id}"
}

output "cidr_block" {
  value = "${module.eu_vpc.cidr_block}"
}

output "public_subnets" {
  value = "${module.eu_vpc.public_subnets}"
}

output "private_subnets" {
  value = "${module.eu_vpc.private_subnets}"
}

output "db_subnets" {
  value = "${module.eu_vpc.db_subnets}"
}

output "public_route_table_id" {
  value = "${module.eu_vpc.public_route_table_id}"
}

output "private_route_table_ids" {
  value = "${module.eu_vpc.private_route_table_ids}"
}

output "nat_eips" {
  value = "${module.eu_vpc.nat_eips}"
}

output "private_zone_id" {
  value = "${module.eu_vpc.private_zone_id}"
}

output "public_zone_id" {
  value = "${module.eu_vpc.public_zone_id}"
}

output "flow_log_id" {
  value = "${module.eu_vpc.flow_log_id}"
}

output "flow_log_cwl_arn" {
  value = "${module.eu_vpc.flow_log_cwl_arn}"
}

output "flow_log_cwl_name" {
  value = "${module.eu_vpc.flow_log_cwl_name}"
}

output "bastion_sg_id" {
  value = "${module.eu_security_groups.bastion_sg_id}"
}

output "zookeeper_sg_id" {
  value = "${module.eu_security_groups.zookeeper_sg_id}"
}

output "bastion_ip" {
  value = "${module.bastion.bastion_ip}"
}

output "kafka_sg_id" {
  value = "${module.eu_security_groups.kafka_sg_id}"
}

output "cassandra_sg_id" {
  value = "${module.eu_security_groups.cassandra_sg_id}"
}

output "mesos-master_sg_id" {
  value = "${module.eu_security_groups.mesos-master_sg_id}"
}

output "mesos-agents_sg_id" {
  value = "${module.eu_security_groups.mesos-agents_sg_id}"
}

output "nimbus_sg_id" {
  value = "${module.eu_security_groups.nimbus_sg_id}"
}

output "storm-supervisors_sg_id" {
  value = "${module.eu_security_groups.storm-supervisors_sg_id}"
}

output "redis_sg_id" {
  value = "${module.eu_security_groups.redis_sg_id}"
}

output "papi_rds_sg_id" {
  value = "${module.eu_security_groups.papi_rds_sg_id}"
}

output "pdb_sg_id" {
  value = "${module.eu_security_groups.pdb_sg_id}"
}

output "service_elb_sg_id" {
  value = "${module.eu_security_groups.service_elb_sg_id}"
}

output "client-terminator_elb_sg_id" {
  value = "${module.eu_security_groups.client-terminator_elb_sg_id}"
}

output "ep-terminator_elb_sg_id" {
  value = "${module.eu_security_groups.ep-terminator_elb_sg_id}"
}

output "kong_elb_sg_id" {
  value = "${module.eu_security_groups.kong_elb_sg_id}"
}

output "papi_elb_sg_id" {
  value = "${module.eu_security_groups.papi_elb_sg_id}"
}

output "client-terminator_sg_id" {
  value = "${module.eu_security_groups.client-terminator_sg_id}"
}

output "ep-terminator_sg_id" {
  value = "${module.eu_security_groups.ep-terminator_sg_id}"
}

output "kong_sg_id" {
  value = "${module.eu_security_groups.kong_sg_id}"
}

output "traefik_sg_id" {
  value = "${module.eu_security_groups.traefik_sg_id}"
}

output "tdb_rds_sg_id" {
  value = "${module.eu_security_groups.tdb_rds_sg_id}"
}

output "monitor_sg_id" {
  value = "${module.eu_security_groups.monitor_sg_id}"
}

output "kong_rds_sg_id" {
  value = "${module.eu_security_groups.kong_rds_sg_id}"
}

output "graphite_sg_id" {
  value = "${module.eu_security_groups.graphite_sg_id}"
}

output "openvpn_sg_id" {
  value = "${module.eu_security_groups.openvpn_sg_id}"
}

output "zone_rds_sg_id" {
  value = "${module.eu_security_groups.zone_rds_sg_id}"
}

output "elasticsearch_sg_id" {
  value = "${module.eu_security_groups.elasticsearch_sg_id}"
}

output "jenkins_sg_id" {
  value = "${module.eu_security_groups.jenkins_sg_id}"
}

output "influxdb_sg_id" {
  value = "${module.eu_security_groups.influxdb_sg_id}"
}

output "load-generator_sg_id" {
  value = "${module.eu_security_groups.load-generator_sg_id}"
}

output "openvpngate_rds_sg_id" {
  value = "${module.eu_security_groups.openvpngate_rds_sg_id}"
}

output "consul_sg_id" {
  value = "${module.eu_security_groups.consul_sg_id}"
}

output "chef-server_sg_id" {
  value = "${module.eu_security_groups.chef-server_sg_id}"
}

output "praxis_sg_id" {
  value = "${module.eu_security_groups.praxis_sg_id}"
}

output "ap-qa_sg_id" {
  value = "${module.eu_security_groups.ap-qa_sg_id}"
}

output "predixy_sg_id" {
  value = "${module.eu_security_groups.predixy_sg_id}"
}

