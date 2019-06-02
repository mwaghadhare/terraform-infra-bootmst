// Output the ID of the EC2 instance created

output "elasticsearch_instance_ids" {
  value = "${join(",", aws_instance.elasticsearch.*.id)}"
}

output "elasticsearch_instance_ips" {
  value = ["${aws_instance.elasticsearch.*.public_ip}"]
}

output "elasticsearch_instance_private_ips" {
  value = ["${aws_instance.elasticsearch.*.private_ip}"]
}
