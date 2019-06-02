output "id" {
  value = "${aws_elasticache_replication_group.redis.id}"
}

output "endpoint" {
  value = "${aws_elasticache_replication_group.redis.primary_endpoint_address}"
}
