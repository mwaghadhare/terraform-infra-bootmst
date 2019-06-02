// Output the ID of the EC2 instance created

output "mesos-master_instance_ids" {
  value = "${join(",", aws_instance.mesos-master.*.id)}"
}

output "mesos-master_instance_ips" {
  value = ["${aws_instance.mesos-master.*.public_ip}"]
}

output "mesos-master_instance_private_ips" {
  value = ["${aws_instance.mesos-master.*.private_ip}"]
}
