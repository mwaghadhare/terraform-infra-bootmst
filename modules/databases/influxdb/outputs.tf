// Output the ID of the EC2 instance created

output "influxdb_instance_ids" {
  value = "${join(",", aws_instance.influxdb.*.id)}"
}

output "influxdb_instance_ips" {
  value = ["${aws_instance.influxdb.*.public_ip}"]
}

output "influxdb_instance_private_ips" {
  value = ["${aws_instance.influxdb.*.private_ip}"]
}
