// Output the ID of the EC2 instance created

output "monitor_instance_ids" {
  value = "${join(",", aws_instance.monitor.*.id)}"
}

output "monitor_instance_ips" {
  value = ["${aws_instance.monitor.*.public_ip}"]
}

output "monitor_instance_private_ips" {
  value = ["${aws_instance.monitor.*.private_ip}"]
}
