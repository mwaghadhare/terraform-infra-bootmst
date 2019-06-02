// Output the ID of the EC2 instance created

output "zookeeper-misc_instance_ids" {
  value = "${join(",", aws_instance.zookeeper-misc.*.id)}"
}

output "zookeeper-misc_instance_ips" {
  value = ["${aws_instance.zookeeper-misc.*.public_ip}"]
}

output "zookeeper-misc_instance_private_ips" {
  value = ["${aws_instance.zookeeper-misc.*.private_ip}"]
}
