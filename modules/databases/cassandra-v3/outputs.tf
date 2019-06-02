// Output the ID of the EC2 instance created

output "cassandra-v3_instance_ids" {
  value = "${join(",", aws_instance.cassandra-v3.*.id)}"
}

output "cassandra-v3_instance_ips" {
  value = ["${aws_instance.cassandra-v3.*.public_ip}"]
}

output "cassandra-v3_instance_private_ips" {
  value = ["${aws_instance.cassandra-v3.*.private_ip}"]
}
