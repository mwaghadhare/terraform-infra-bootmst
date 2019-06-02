// Output the ID of the EC2 instance created

output "ap-qa_instance_ids" {
  value = "${join(",", aws_instance.ap-qa.*.id)}"
}

output "ap-qa_instance_ips" {
  value = ["${aws_instance.ap-qa.*.public_ip}"]
}

output "ap-qa_instance_private_ips" {
  value = ["${aws_instance.ap-qa.*.private_ip}"]
}
