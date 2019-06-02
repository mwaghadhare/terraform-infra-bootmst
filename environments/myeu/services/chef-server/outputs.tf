output "chef-server_instance_ids" {
  value = "${module.chef-server.chef-server_instance_ids}"
}

output "chef-server_instance_ips" {
  value = "${module.chef-server.chef-server_instance_ips}"
}

output "chef-server_instance_private_ips" {
  value = "${module.chef-server.chef-server_instance_private_ips}"
}
