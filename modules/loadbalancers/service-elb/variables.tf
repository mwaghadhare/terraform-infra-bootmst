variable "region" {
  default = ""
}

variable "env" {
  default = ""
}

variable "name" {
  description = "The name of the ELB"
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the ELB"
  type        = "list"
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = "list"
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
}

variable "cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  default     = true
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  default     = 60
}

variable "connection_draining" {
  description = "Boolean to enable connection draining"
  default     = false
}

variable "connection_draining_timeout" {
  description = "The time in seconds to allow for connections to drain"
  default     = 300
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

# Listener
variable "listener" {
  description = "A list of listener blocks"
  type        = "list"
}

# Access logs
variable "access_logs" {
  description = "An access logs block"
  type        = "list"
  default     = []
}

# Health check
variable "health_check" {
  description = "A health check block"
  type        = "list"
}

variable "zone_id_private" {}

variable "zone_id_public" {}

variable "instances" {
  type = "list"
}

variable "log_bucket" {}

variable "log_bucket_prefix" {}

variable "topic_arn" {
  description = ""
}

variable "comparison_operator" {
  description = ""
}

variable "evaluation_periods" {
  description = ""
}

variable "namespace" {
  description = ""
}

variable "period" {
  description = ""
}

variable "statistic" {
  description = ""
}

variable "unhealthy_threshold" {
  description = ""
}

variable "unhealthy_metric_name" {
  description = ""
}

variable "requestcount_metric_name" {
  description = ""
}

variable "requestcount_threshold" {
  description = ""
}

variable "http5xx_metric_name" {
  description = ""
}

variable "http5xx_threshold" {
  description = ""
}

variable "latency_metric_name" {
  description = ""
}

variable "latency_threshold" {
  description = ""
}
