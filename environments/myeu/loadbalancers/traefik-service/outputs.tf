output "traefik-service_instance_ids" {
  value = "${module.traefik-service.traefik-service_instance_ids}"
}

output "traefik-service_instance_ips" {
  value = "${module.traefik-service.traefik-service_instance_ips}"
}

output "traefik-service_instance_private_ips" {
  value = "${module.traefik-service.traefik-service_instance_private_ips}"
}
