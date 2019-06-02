// Output the ID of the EC2 instance created

output "nimbus_instance_ids" {
  value = "${join(",", aws_instance.nimbus.*.id)}"
}

output "nimbus_instance_ips" {
  value = ["${aws_instance.nimbus.*.public_ip}"]
}

output "nimbus_instance_private_ips" {
  value = ["${aws_instance.nimbus.*.private_ip}"]
}
