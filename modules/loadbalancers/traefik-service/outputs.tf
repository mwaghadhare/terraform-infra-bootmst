// Output the ID of the EC2 instance created

output "traefik-service_instance_ids" {
  value = "${join(",", aws_instance.traefik-service.*.id)}"
}

output "traefik-service_instance_ips" {
  value = ["${aws_instance.traefik-service.*.public_ip}"]
}

output "traefik-service_instance_private_ips" {
  value = ["${aws_instance.traefik-service.*.private_ip}"]
}
