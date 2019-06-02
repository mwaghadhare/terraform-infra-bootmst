output "mesos-master_instance_ids" {
  value = "${module.mesos-master.mesos-master_instance_ids}"
}

output "mesos-master_instance_ips" {
  value = "${module.mesos-master.mesos-master_instance_ips}"
}

output "mesos-master_instance_private_ips" {
  value = "${module.mesos-master.mesos-master_instance_private_ips}"
}
