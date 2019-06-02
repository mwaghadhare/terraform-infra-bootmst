output "kong_instance_ids" {
  value = "${module.kong.kong_instance_ids}"
}

output "kong_instance_ips" {
  value = "${module.kong.kong_instance_ips}"
}

output "kong_instance_private_ips" {
  value = "${module.kong.kong_instance_private_ips}"
}
