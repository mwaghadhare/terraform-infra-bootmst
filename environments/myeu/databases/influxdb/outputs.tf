output "influxdb_instance_ids" {
  value = "${module.influxdb.influxdb_instance_ids}"
}

output "influxdb_instance_ips" {
  value = "${module.influxdb.influxdb_instance_ips}"
}

output "influxdb_instance_private_ips" {
  value = "${module.influxdb.influxdb_instance_private_ips}"
}
