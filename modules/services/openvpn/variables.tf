variable "name" {
  description = "Name of the openvpn cluster (for ex. openvpn)"
  default     = "openvpn"
}

variable "env" {
  description = "Environment name, like testpad-000, staging-000 etc."
  default     = ""
}

variable "ami_id" {
  description = "AMI ID for the OpenVPN"
  default = ""
}

variable "instance_type" {
  description = "EC2 type for openvpn instances"
  default     = "t2.medium"
}

variable "subnet_ids" {
  description = "List of VPC subnets the instance(s) will go in"
  type        = "list"
}

variable "security_groups" {
  description = "The associated security groups"
  type        = "list"
}

variable "number_of_instances" {
  description = "Number of instances in the openvpn cluster"
  default     = ""
}

variable "key_name" {
  description = "SSH key to use"
}

variable "region" {
  description = "AWS region where to create the openvpn instances"
  default     = ""
}

variable "instance_profile" {
  description = "The IAM Instance Profile to launch the instances with; if undefined the module will create one"
  default     = ""
}

variable "ebs_optimized" {
  description = "Do we need EBS optimized instances? (not all instances support this)"
  default     = true
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true."
  default     = ""
}

variable "monitoring" {
  description = " the launched EC2 instance will have detailed monitoring enabled. "
  default     = ""
}

variable "zone_id_private" {
  description = "The zone_id of the route53 private zone where to create dns records"
}

variable "zone_id_public" {
  description = "The zone_id of the route53 public zone where to create dns records"
}

variable "org_validator" {
  description = "Org validator to be use by Chef to bootstrap"
  default     = ""
}

variable "fullaz" {
  description = " Availability Zone in which instance will get launch"
  default     = ""
}

variable "user" {
  description = "The default user to get Chef client in to bootstrap nodes"
  default     = ""
}


variable "root_volume_type" {
  description = "The root volume type for the isntance like gp2, piops"
  default     = ""
}

variable "root_volume_size" {
  description = "The root volume size default is 8"
  default     = ""
}

variable "root_delete_on_termination" {
  description = "Boolean to make sure we need to delete root volume after termination or not?"
  default     = ""
}


variable "cpu_topic_arn" {
  description = ""
}

variable "status_check_arn" {
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

variable "threshold" {
  description = ""
}

variable "cpu_metric_name" {
  description = ""
}

variable "cpu_statistic" {
  description = ""
}

variable "cpu_threshold" {
  description = ""
}

variable "metric_name" {
  description = ""
}
