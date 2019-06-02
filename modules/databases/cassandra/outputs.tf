// Output the ID of the EC2 instance created

output "cassandra_instance_ids" {
  value = "${join(",", aws_instance.cassandra.*.id)}"
}

output "cassandra_instance_ips" {
  value = ["${aws_instance.cassandra.*.public_ip}"]
}

output "cassandra_instance_private_ips" {
  value = ["${aws_instance.cassandra.*.private_ip}"]
}
