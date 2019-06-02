variable "region" {
  default = "eu-central-1"
}

variable "availability_zone" {
  default = "eu-central-1b"
}

variable "zone_id_public" {
  default = ""
}

variable "zone_id_private" {
  default = ""
}

variable "name" {
  description = "Name of the redis cluster (for ex. redis)"
  default     = "redis-default"
}

variable "env" {
  description = "Environment name, like eu-000, staging-000 etc."
  default     = "eu"
}

variable "cache_identifier" {
  description = "Cache Identifier"
  default     = "redis-default"
}

variable "maintenance_window" {
  default = "sun:02:30-sun:03:30"
}

variable "desired_clusters" {
  default = "2"
}

variable "node_type" {
  default = "cache.r4.xlarge"
}

variable "engine_version" {
  default = "3.2.10"
}

variable "automatic_failover_enabled" {
  default = true
}

variable "port" {
  description = "Security group for the Elastic-Cache Redis default is 6379"
  default     = "6379"
}

variable "route53_record" {
  default = "redis-000"
}

variable "common_topic_arn" {
  description = "SNS topic arn for CW EU"
  default     = "arn:aws:sns:eu-central-1:8888xxxxx:commonARN"
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = " The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "cpu_metric_name" {
  description = "The name for the alarm's associated metric."
  default     = "CPUUtilization"
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric. "
  default     = "AWS/ElastiCache"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  default     = "300"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "80"
}

variable "comparison_operator_cachmem" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
  default     = "LessThanOrEqualToThreshold"
}

variable "memory_metric_name" {
  description = "The value against which the specified statistic is compared."
  default     = "FreeableMemory"
}

variable "redis_memory_threshold" {
  description = "Redis Memory threshold"
  default     = "1000000000"
}

variable "replicationlag_metric_name" {
  description = "The value against which the specified statistic is compared."
  default     = "ReplicationLag"
}

variable "replicationlag_threshold" {
  description = "Repication lag of Redis threshold"
  default     = "800"
}

variable "swapmem_metric_name" {
  description = "The value against which the specified statistic is compared."
  default     = "SwapUsage"
}

variable "swapmem_threshold" {
  description = "Redis Memory threshold"
  default     = "500000000"
}

variable "currconnection_metric_name" {
  description = "The value against which the specified statistic is compared."
  default     = "CurrConnections"
}

variable "currconnection_threshold" {
  description = "Redis Memory threshold"
  default     = "3000"
}


variable "snapshot_retention_limit" { 
  default     = 5
}

