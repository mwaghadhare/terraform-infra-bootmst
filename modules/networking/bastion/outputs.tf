output "bastion_instance_id" {
  value = "${aws_instance.bastion.*.id}"
}

output "bastion_ip" {
  value = "${aws_instance.bastion.*.public_ip}"
}

output "bastion_fqdn" {
  value = "${aws_route53_record.route-53-public.*.fqdn}"
}
