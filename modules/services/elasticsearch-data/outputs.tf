// Output the ID of the EC2 instance created

output "elasticsearch-data_instance_ids" {
  value = "${join(",", aws_instance.elasticsearch-data.*.id)}"
}

output "elasticsearch-data_instance_ips" {
  value = ["${aws_instance.elasticsearch-data.*.public_ip}"]
}

output "elasticsearch-data_instance_private_ips" {
  value = ["${aws_instance.elasticsearch-data.*.private_ip}"]
}
