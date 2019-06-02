variable "name" {
  description = "Name of the kafka cluster (for ex. kafka)"
  default     = ""
}

variable "key_access_role" {
  description = "Name of the kafka cluster (for ex. kafka)"
  default     = ""
}

variable "env" {
  description = "Environment name, like testpad-000, staging-000 etc."
  default     = ""
}

variable "iam_instance_profile" {
  description = "Instance Profile for EP"
  default     = ""
}

#variable "ami_id" {
#  description = "AMI ID to be use"
#  default     = ""
#}

variable "aws_account_id" {
  description = "AWS Account  ID to be use"
  default     = ""
}

variable "instance_type" {
  description = "EC2 type for ep-terminator instances"
  default     = ""
}

variable "hostnames" {
  default = {
    "0" = "ep-terminator-000"
    "1" = "ep-terminator-001"
  }
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
  description = "Number of instances in the kafka cluster"
  default     = ""
}

variable "key_name" {
  description = "SSH key to use"
}

variable "region" {
  description = "AWS region where to create the kafka instances"
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

variable "bastion_host" {
  description = "Bastion Host to get the SSH connection and bootstrap the server"
  default     = ["mystandardqueue1"]
}

variable "bastion_user" {
  description = "bastion user"
  default     = "ubuntu"
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

variable "chef_fqdn" {
  default     = ""
}

#variable "data_device_name" {
#  description = "The device name for the EBS storage either data or opt"
#  default     = ""
#}

#variable "data_volume_type" {
#  description = "The data or opt volume type for the isntance like gp2, piops"
#  default     = ""
#}

#variable "data_volume_size" {
#  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
#  default     = ""
#}

#variable "data_delete_on_termination" {
#  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
#  default     = ""
#}