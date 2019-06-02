// Output the ID of the EC2 instance created

output "chef-server_instance_ids" {
  value = "${join(",", aws_instance.chef-server.*.id)}"
}

output "chef-server_instance_ips" {
  value = ["${aws_instance.chef-server.*.public_ip}"]
}

output "chef-server_instance_private_ips" {
  value = ["${aws_instance.chef-server.*.private_ip}"]
}
