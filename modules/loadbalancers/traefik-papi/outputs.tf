// Output the ID of the EC2 instance created

output "traefik-papi_instance_ids" {
  value = "${join(",", aws_instance.traefik-papi.*.id)}"
}

output "traefik-papi_instance_ips" {
  value = ["${aws_instance.traefik-papi.*.public_ip}"]
}

output "traefik-papi_instance_private_ips" {
  value = ["${aws_instance.traefik-papi.*.private_ip}"]
}
