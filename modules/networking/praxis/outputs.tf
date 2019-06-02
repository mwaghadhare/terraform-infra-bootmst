output "praxis_instance_id" {
  value = "${aws_instance.praxis.*.id}"
}

output "praxis_ip" {
  value = "${aws_instance.praxis.*.public_ip}"
}

output "praxis_fqdn" {
  value = "${aws_route53_record.route-53-public.*.fqdn}"
}


output "jenkins_instance_private_ips" {
  value = ["${aws_instance.praxis.*.private_ip}"]
}

