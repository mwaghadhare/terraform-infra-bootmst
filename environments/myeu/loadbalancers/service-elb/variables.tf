variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "eu"
}

variable "name" {
  description = "The name of the ELB"
  default     = "service-elb"
}

variable "internal" {
  description = "If true, ELB will be an internal ELB"
  default     = false
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

# ELB attachment

variable "number_of_instances" {
  description = "Number of instances to attach to ELB"
  default     = 2
}

variable "instances" {
  description = "List of instances ID to place in the ELB pool"
  type        = "list"
  default     = []
}

variable "zone_id_private" {}

variable "zone_id_public" {}

variable "topic_arn" {
  description = "SNS topic arn for unhealthy host count"
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

variable "unhealthy_metric_name" {
  description = "The name for the alarm's associated metric."
  default     = "UnHealthyHostCount"
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric. "
  default     = "AWS/ELB"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  default     = "300"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Maximum"
}

variable "unhealthy_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "1"
}

variable "requestcount_metric_name" {
  description = "The number of request count on ELB"
  default     = "RequestCount"
}

variable "requestcount_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "1000"
}

variable "http5xx_metric_name" {
  description = "The number of 5xx request to elb"
  default     = "HTTPCode_ELB_5XX"
}

variable "http5xx_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "100"
}

variable "latency_metric_name" {
  description = "The number of requests coming to elb"
  default     = "Latency"
}

variable "latency_threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "300"
}
