variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "eu"
}

variable "instance_type" {
  default = "m4.large"
}

variable "zone_id_public" {
  default = ""
}

variable "zone_id_private" {
  default = ""
}

variable "user" {
  default = "ubuntu"
}

variable "name" {
  default = "traefik-papi"
}

variable "org" {
  default = "mysys"
}

variable "number_of_instances" {
  default = 1
}

variable "source_dest_check" {
  default = false
}

variable "monitoring" {
  default = true
}

variable "root_volume_type" {
  description = "The root volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The root volume size default is 8"
  default     = "16"
}

variable "root_delete_on_termination" {
  description = "Boolean to make sure we need to delete root volume after termination or not?"
  default     = "false"
}

variable "data_device_name" {
  description = "The device name for the EBS storage either data or opt"
  default     = "/dev/sdc"
}

variable "data_volume_type" {
  description = "The data or opt volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "data_volume_size" {
  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
  default     = "100"
}

variable "data_delete_on_termination" {
  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
  default     = "false"
}

variable "opt_device_name" {
  description = "The device name for the EBS storage either data or opt"
  default     = "/dev/sdb"
}

variable "opt_volume_type" {
  description = "The data or opt volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "opt_volume_size" {
  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
  default     = "30"
}

variable "opt_delete_on_termination" {
  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
  default     = "false"
}

variable "cpu_topic_arn" {
  description = "SNS topic arn for CPU utilization"
  default     = "arn:aws:sns:eu-central-1:8888xxxxx:commonARN"
}

variable "status_check_arn" {
  description = "Status Check Failed arn for CPU utilization"
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

variable "metric_name" {
  description = "The name for the alarm's associated metric."
  default     = "StatusCheckFailed"
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric. "
  default     = "AWS/EC2"
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  default     = "300"
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Maximum"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
  default     = "1"
}

variable "cpu_metric_name" {
  description = "The name for the alarm's associated metric."
  default     = "CPUUtilization"
}

variable "cpu_statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "cpu_threshold" {
  description = "Status Check Failed arn for CPU utilization"
  default     = "80"
}

variable "chef_fqdn" {
  description = "Chef server FQDN"
  default     = "https://chef-server-000-eu.my.pvt/organizations/mysys-eu"
}
