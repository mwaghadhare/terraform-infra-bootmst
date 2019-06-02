resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${lower(var.cache_identifier)}"
  replication_group_description = "Replication group for Redis"
  automatic_failover_enabled    = "${var.automatic_failover_enabled}"
#  number_cache_clusters         = "${var.desired_clusters}"
  node_type                     = "${var.node_type}"
  engine_version                = "${var.engine_version}"
  parameter_group_name          = "${aws_elasticache_parameter_group.redis_parameter_group.name}"
  security_group_ids            = ["${var.security_groups}"]
  subnet_group_name             = "${aws_elasticache_subnet_group.redis_subnet_group.name}"
  maintenance_window            = "${var.maintenance_window}"
  snapshot_retention_limit      = "${var.snapshot_retention_limit}"
  #  snapshot_window            = "${var.snapshot_window }"
  port                          = "${var.port}"
  
  cluster_mode {
    replicas_per_node_group     = "${var.replicas_per_node_groups}"
    num_node_groups             = "${var.node_groups}"
  }
  
  tags {
    Name        = "${var.name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}
