output "jenkins_instance_id" {
  value = "${aws_instance.jenkins.*.id}"
}

output "jenkins_ip" {
  value = "${aws_instance.jenkins.*.public_ip}"
}

output "jenkins_fqdn" {
  value = "${aws_route53_record.route-53-public.*.fqdn}"
}

output "jenkins_instance_private_ips" {
  value = ["${aws_instance.jenkins.*.private_ip}"]
}
