// Output the ID of the EC2 instance created

output "pdb_instance_ids" {
  value = "${join(",", aws_instance.pdb.*.id)}"
}

output "pdb_instance_ips" {
  value = ["${aws_instance.pdb.*.public_ip}"]
}

output "pdb_instance_private_ips" {
  value = ["${aws_instance.pdb.*.private_ip}"]
}
