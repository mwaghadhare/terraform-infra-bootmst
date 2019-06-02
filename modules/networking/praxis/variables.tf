variable "name" {
  description = "Name of the praxis cluster (for ex. praxis)"
  default     = "praxis"
}

variable "env" {
  description = "Environment name, like testpad-000, staging-000 etc."
  default     = ""
}

variable "instance_type" {
  description = "EC2 type for zookeeper instances"
  default     = "t2.medium"
}

variable "subnet_id" {
  description = "List of VPC subnets the instance(s) will go in"
}

variable "security_groups" {
  description = "The associated security groups"
  type        = "list"
}

variable "number_of_instances" {
  description = "Number of instances in the zookeeper cluster"
  default     = 1
}

variable "key_name" {
  description = "SSH key to use"
}

variable "region" {
  description = "AWS region where to create the zookeeper instances"
  default     = ""
}

variable "instance_profile" {
  description = "The IAM Instance Profile to launch the instances with; if undefined the module will create one"
  default     = ""
}

variable "ebs_optimized" {
  description = "Do we need EBS optimized instances? (not all instances support this)"
  default     = false
}

variable "zone_id_private" {
  description = "The zone_id of the route53 private zone where to create dns records"
}

variable "zone_id_public" {
  description = "The zone_id of the route53 public zone where to create dns records"
}

variable "ami_id" {
  description = "The AMI to use for zookeeper instances."
  default     = ""
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

variable "device_name" {
  description = "The device name for the EBS storage either data or opt"
  default     = ""
}

variable "volume_type" {
  description = "The data or opt volume type for the isntance like gp2, piops"
  default     = ""
}

variable "volume_size" {
  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
  default     = ""
}

variable "delete_on_termination" {
  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
  default     = ""
}

variable "chef_fqdn" {
  description = "Chef Server FQDN"
  default     = ""
}
