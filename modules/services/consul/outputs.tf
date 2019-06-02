// Output the ID of the EC2 instance created

output "consul_instance_ids" {
  value = "${join(",", aws_instance.consul.*.id)}"
}

output "consul_instance_ips" {
  value = ["${aws_instance.consul.*.public_ip}"]
}

output "consul_instance_private_ips" {
  value = ["${aws_instance.consul.*.private_ip}"]
}
