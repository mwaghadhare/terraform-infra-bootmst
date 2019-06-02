// Output the ID of the EC2 instance created

output "load-generator_instance_ids" {
  value = "${join(",", aws_instance.load-generator.*.id)}"
}

output "load-generator_instance_ips" {
  value = ["${aws_instance.load-generator.*.public_ip}"]
}

output "load-generator_instance_private_ips" {
  value = ["${aws_instance.load-generator.*.private_ip}"]
}
