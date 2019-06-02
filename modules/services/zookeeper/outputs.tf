// Output the ID of the EC2 instance created

output "zookeeper_instance_ids" {
  value = "${join(",", aws_instance.zookeeper.*.id)}"
}

output "zookeeper_instance_ips" {
  value = ["${aws_instance.zookeeper.*.public_ip}"]
}

output "zookeeper_instance_private_ips" {
  value = ["${aws_instance.zookeeper.*.private_ip}"]
}
