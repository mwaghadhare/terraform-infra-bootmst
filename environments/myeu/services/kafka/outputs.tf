output "kafka_instance_ids" {
  value = "${module.kafka.kafka_instance_ids}"
}

output "kafka_instance_ips" {
  value = "${module.kafka.kafka_instance_ips}"
}

output "kafka_instance_private_ips" {
  value = "${module.kafka.kafka_instance_private_ips}"
}
