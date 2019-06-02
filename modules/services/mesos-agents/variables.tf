variable "name" {
  description = "Name of the mesos-agents cluster (for ex. mesos-agents)"
  default     = "mesos-agents"
}

variable "env" {
  description = "Environment name, like testpad-000, staging-000 etc."
  default     = ""
}

variable "domain" {
  description = "Domain name to be associated"
  default     = ""
}

variable "private_domain" {
  description = "Private Domain name to be associated"
  default     = ""
}

variable "instance_type" {
  description = "EC2 type for mesos-agents instances"
  default     = ""
}

variable "subnet_ids" {
  description = "List of VPC subnets the instance(s) will go in"
  type        = "list"
}

variable "security_group" {
  description = "The associated security groups"
  type        = "list"
}

variable "number_of_instances" {
  description = "Number of instances in the mesos-agents cluster"
  default     = 3
}

variable "key_name" {
  description = "SSH key to use"
}

variable "region" {
  description = "AWS region where to create the mesos-agents instances"
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

variable "strategy" {
  description = "Default strategy for the AWS Fleet"
  default     = ""
}

variable "validity" {
  description = "Date till the Fleet will live "
  default     = ""
}

variable "fleet_role" {
  description = "Default AWS Fleet role to be attach to all instances"
  default     = ""
}

variable "replace_unhealthy_instances" {
  description = "Boolean to terminate instances as soon as Fleet goes away default should be true"
  default     = ""
}

variable "ami_id" {
  description = "AMI ID as we back Mesos Agenst AMI via Packer and not use default Ubuntu AMI."
  default     = ""
}

variable "spotprice" {
  description = "Per core price that you want to bid for the Fleet "
  default     = ""
}

variable "targetcapacity_a" {
  description = "Capacity we want to keep for the Fleet"
  default     = ""
}

variable "targetcapacity_b" {
  description = "Capacity we want to keep for the Fleet"
  default     = ""
}

variable "targetcapacity_c" {
  description = "Capacity we want to keep for the Fleet"
  default     = ""
}
variable "terminate_instances" {
  description = "Booleean to terminate instances as soon as Fleet goes away."
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

variable "wc-four" {
  description = "Weighted capacity 4"
  default     = ""
}

variable "wc-eight" {
  description = "Weighted capacity 8"
  default     = ""
}

variable "wc-sixteen" {
  description = "Weighted capacity 16"
  default     = ""
}

variable "m22xlarge" {
  description = "Instance Type m2.2xlarge"
  default     = ""
}

variable "m24xlarge" {
  description = "Instance Type m2.4xlarge"
  default     = ""
}

variable "m3xlarge" {
  description = "Instance Type m3xlarge"
  default     = ""
}

variable "m32xlarge" {
  description = "Instance Type m3.2xlarge"
  default     = ""
}

variable "m4xlarge" {
  description = "Instance Type m4.xlarge"
  default     = ""
}

variable "m42xlarge" {
  description = "Instance Type m4.2xlarge"
  default     = ""
}

variable "m44xlarge" {
  description = "Instance Type m4.4xlarge"
  default     = ""
}

variable "m5xlarge" {
  description = "Instance Type m5.xlarge"
  default     = ""
}

variable "m52xlarge" {
  description = "Instance Type m5.2xlarge"
  default     = ""
}

variable "m54xlarge" {
  description = "Instance Type m5.4xlarge"
  default     = ""
}

variable "c3xlarge" {
  description = "Instance Type c3.xlarge"
  default     = ""
}

variable "c32xlarge" {
  description = "Instance Type c3.2xlarge"
  default     = ""
}

variable "c34xlarge" {
  description = "Instance Type c3.4xlarge"
  default     = ""
}

variable "c4xlarge" {
  description = "Instance Type c4.xlarge"
  default     = ""
}

variable "c42xlarge" {
  description = "Instance Type c4.2xlarge"
  default     = ""
}

variable "c44xlarge" {
  description = "Instance Type c4.4xlarge"
  default     = ""
}

variable "c5xlarge" {
  description = "Instance Type c5.xlarge"
  default     = ""
}

variable "c52xlarge" {
  description = "Instance Type c5.2xlarge"
  default     = ""
}

variable "c54xlarge" {
  description = "Instance Type c5.4xlarge"
  default     = ""
}

variable "i3xlarge" {
  description = "Instance Type i3.xlarge"
  default     = ""
}

variable "i32xlarge" {
  description = "Instance Type i3.2xlarge"
  default     = ""
}

variable "i34xlarge" {
  description = "Instance Type i3.4xlarge"
  default     = ""
}

variable "r3xlarge" {
  description = "Instance Type r3.xlarge"
  default     = ""
}

variable "r32xlarge" {
  description = "Instance Type r3.2xlarge"
  default     = ""
}

variable "r34xlarge" {
  description = "Instance Type r3.4xlarge"
  default     = ""
}

variable "r4xlarge" {
  description = "Instance Type r4.xlarge"
  default     = ""
}

variable "r42xlarge" {
  description = "Instance Type r4.2xlarge"
  default     = ""
}

variable "r44xlarge" {
  description = "Instance Type r4.4xlarge"
  default     = ""
}
