// Output the ID of the EC2 instance created

output "openvpn_instance_ids" {
  value = "${join(",", aws_instance.openvpn.*.id)}"
}

output "openvpn_instance_ips" {
  value = ["${aws_instance.openvpn.*.public_ip}"]
}

output "openvpn_instance_private_ips" {
  value = ["${aws_instance.openvpn.*.private_ip}"]
}
