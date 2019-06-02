// Output the ID of the EC2 instance created

output "client-terminator_instance_ids" {
  value = "${join(",", aws_instance.client-terminator.*.id)}"
}

output "client-terminator_instance_ips" {
  value = ["${aws_instance.client-terminator.*.public_ip}"]
}

output "client-terminator_instance_private_ips" {
  value = ["${aws_instance.client-terminator.*.private_ip}"]
}
