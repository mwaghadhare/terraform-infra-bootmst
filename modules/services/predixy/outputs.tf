// Output the ID of the EC2 instance created

output "predixy_instance_ids" {
  value = "${join(",", aws_instance.predixy.*.id)}"
}

output "predixy_instance_ips" {
  value = ["${aws_instance.predixy.*.public_ip}"]
}

output "predixy_instance_private_ips" {
  value = ["${aws_instance.predixy.*.private_ip}"]
}
