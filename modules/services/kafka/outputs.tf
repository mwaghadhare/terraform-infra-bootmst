// Output the ID of the EC2 instance created

output "kafka_instance_ids" {
  value = "${join(",", aws_instance.kafka.*.id)}"
}

output "kafka_instance_ips" {
  value = ["${aws_instance.kafka.*.public_ip}"]
}

output "kafka_instance_private_ips" {
  value = ["${aws_instance.kafka.*.private_ip}"]
}
