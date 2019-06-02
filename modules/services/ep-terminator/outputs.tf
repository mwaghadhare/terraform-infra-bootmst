// Output the ID of the EC2 instance created

output "ep-terminator_instance_ids" {
  value = "${join(",", aws_instance.ep-terminator.*.id)}"
}

output "ep-terminator_instance_ips" {
  value = ["${aws_instance.ep-terminator.*.public_ip}"]
}

output "ep-terminator_instance_private_ips" {
  value = ["${aws_instance.ep-terminator.*.private_ip}"]
}
