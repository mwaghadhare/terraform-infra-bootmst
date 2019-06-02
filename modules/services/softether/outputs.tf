// Output the ID of the EC2 instance created

output "softether_instance_ids" {
  value = "${join(",", aws_instance.softether.*.id)}"
}

output "softether_instance_ips" {
  value = ["${aws_instance.softether.*.public_ip}"]
}

output "softether_instance_private_ips" {
  value = ["${aws_instance.softether.*.private_ip}"]
}
