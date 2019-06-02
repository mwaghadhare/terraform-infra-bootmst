output "consul_instance_ids" {
  value = "${module.consul.consul_instance_ids}"
}

output "consul_instance_ips" {
  value = "${module.consul.consul_instance_ips}"
}

output "consul_instance_private_ips" {
  value = "${module.consul.consul_instance_private_ips}"
}
