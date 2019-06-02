// Output the ID of the EC2 instance created

output "graphite_instance_ids" {
  value = "${join(",", aws_instance.graphite.*.id)}"
}

output "graphite_instance_ips" {
  value = ["${aws_instance.graphite.*.public_ip}"]
}

output "graphite_instance_private_ips" {
  value = ["${aws_instance.graphite.*.private_ip}"]
}
