// Output the ID of the EC2 instance created

output "nimbus-ha_instance_ids" {
  value = "${join(",", aws_instance.nimbus-ha.*.id)}"
}

output "nimbus-ha_instance_ips" {
  value = ["${aws_instance.nimbus-ha.*.public_ip}"]
}

output "nimbus-ha_instance_private_ips" {
  value = ["${aws_instance.nimbus-ha.*.private_ip}"]
}
