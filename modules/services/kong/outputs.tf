// Output the ID of the EC2 instance created

output "kong_instance_ids" {
  value = "${join(",", aws_instance.kong.*.id)}"
}

output "kong_instance_ips" {
  value = ["${aws_instance.kong.*.public_ip}"]
}

output "kong_instance_private_ips" {
  value = ["${aws_instance.kong.*.private_ip}"]
}
