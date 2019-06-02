variable "name" {
  description = "Name of the redis cluster (for ex. redis)"
  default     = "redis"
}

variable "env" {
  description = "Environment name, like testpad-000, staging-000 etc."
  default     = ""
}

variable "availability_zone" {
  default = ""
}

variable "cache_identifier" {}

variable "parameter_group" {
  default = "default.redis3.2"
}

variable "subnet_ids" {
  description = "List of VPC subnets the instance(s) will go in"
  type        = "list"
}

variable "maintenance_window" {}

#variable "snapshot_window" {}

#variable "desired_clusters" {
#  default = "1"
#}

variable "node_type" {
  default = ""
}

variable "engine_version" {
  default = ""
}

#variable "automatic_failover_enabled" {
#  default = ""
#}

variable "port" {
  description = "port for the Elastic-Cache Redis default is 6379"
  default     = ""
}

variable "security_groups" {
  description = "The associated security groups"
  type        = "list"
}

variable "zone_id_public" {
  description = "The zone_id of the route53 public zone where to create dns records"
}

variable "zone_id_private" {
  description = "The zone_id of the route53 private zone where to create dns records"
}

#variable "route53_record" {
#  description = "The name of the route53 private hosted  dns records"
#}

# variable "common_topic_arn" {
#   description = ""
# }

# variable "comparison_operator" {
#   description = ""
# }

# variable "evaluation_periods" {
#   description = ""
# }

# variable "namespace" {
#   description = ""
# }

# variable "period" {
#   description = ""
# }

# variable "statistic" {
#   description = ""
# }

# variable "threshold" {
#   description = ""
# }

# variable "cpu_metric_name" {
#   description = ""
# }

# variable "memory_metric_name" {
#   description = ""
# }

# variable "redis_memory_threshold" {
#   description = ""
# }

# variable "comparison_operator_cachmem" {
#   description = ""
# }

# variable "replicationlag_metric_name" {
#   description = ""
# }

# variable "replicationlag_threshold" {
#   description = ""
# }

# variable "swapmem_metric_name" {
#   description = ""
# }

# variable "swapmem_threshold" {
#   description = ""
# }

# variable "currconnection_metric_name" {
#   description = ""
# }

# variable "currconnection_threshold" {
#   description = ""
# }
variable "snapshot_retention_limit" {
  description = "(Optional, Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro or cache.t2.* cache node"
}

variable "node_groups" {
  description = "Number of nodes groups to create in the cluster"
  default     = "" 
}


variable "replicas_per_node_groups" {
  description = "Number of replicas per node group"
  default     = ""
}

variable "automatic_failover_enabled" {
  description = "failover enabled not needed for cluster mode"
  default  = ""
}
