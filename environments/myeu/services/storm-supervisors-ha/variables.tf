variable "org" {
  default = "mysys"
}

variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "eu"
}

variable "domain" {
  default = "my.com"
}

variable "zone_id_public" {
  default = "Z40ZXH8LYX9EU"
}

variable "zone_id_private" {
  default = "Z3xxxxxxxx"
}

variable "strategy" {
  description = "Default strategy for the AWS Fleet"
  default     = "diversified"
}

variable "validity" {
  description = "Date till the Fleet will live "
  default     = "2024-12-04T20:44:20Z"
}

variable "fleet_role" {
  description = "Default AWS Fleet role to be attach to all instances"
  default     = "arn:aws:iam::8888xxxxx:role/aws-ec2-spot-fleet-role"
}

variable "replace_unhealthy_instances" {
  description = "Boolean to terminate instances as soon as Fleet goes away default should be true"
  default     = "true"
}

variable "ami_id" {
  description = "AMI ID as we back Mesos Agenst AMI via Packer and not use default Ubuntu AMI."
  default     = "ami-0953d55afbbce8457"
}

variable "spotprice" {
  description = "Per core price that you want to bid for the Fleet "
  default     = "0.08"
}

variable "targetcapacity_a" {
  description = "Capacity we want to keep for the Fleet"
  default     = "100"
}

variable "targetcapacity_b" {
  description = "Capacity we want to keep for the Fleet"
  default     = "20"
}

variable "targetcapacity_c" {
  description = "Capacity we want to keep for the Fleet"
  default     = "20"
}

variable "terminate_instances" {
  description = "Booleean to terminate instances as soon as Fleet goes away."
  default     = "true"
}

variable "root_volume_type" {
  description = "The root volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The root volume size default is 8"
  default     = "100"
}

variable "root_delete_on_termination" {
  description = "Boolean to make sure we need to delete root volume after termination or not?"
  default     = "true"
}

variable "wc-four" {
  description = "Weighted capacity 4"
  default     = "4"
}

variable "wc-eight" {
  description = "Weighted capacity 8"
  default     = "8"
}

variable "wc-sixteen" {
  description = "Weighted capacity 16"
  default     = "16"
}

variable "m22xlarge" {
  description = "Instance Type m2.2xlarge"
  default     = "m3.2xlarge"
}

variable "m24xlarge" {
  description = "Instance Type m2.4xlarge"
  default     = "m4.4xlarge"
}

variable "m3xlarge" {
  description = "Instance Type m3xlarge"
  default     = "m3.xlarge"
}

variable "m32xlarge" {
  description = "Instance Type m3.2xlarge"
  default     = "m3.2xlarge"
}

variable "m4xlarge" {
  description = "Instance Type m4.xlarge"
  default     = "m4.xlarge"
}

variable "m42xlarge" {
  description = "Instance Type m4.2xlarge"
  default     = "m4.2xlarge"
}

variable "m44xlarge" {
  description = "Instance Type m4.4xlarge"
  default     = "m4.4xlarge"
}

variable "m5xlarge" {
  description = "Instance Type m5.xlarge"
  default     = "m5.xlarge"
}

variable "m52xlarge" {
  description = "Instance Type m5.2xlarge"
  default     = "m5.2xlarge"
}

variable "m54xlarge" {
  description = "Instance Type m5.4xlarge"
  default     = "m5.4xlarge"
}

variable "c3xlarge" {
  description = "Instance Type c3.xlarge"
  default     = "c3.xlarge"
}

variable "c32xlarge" {
  description = "Instance Type c3.2xlarge"
  default     = "c3.2xlarge"
}

variable "c34xlarge" {
  description = "Instance Type c3.4xlarge"
  default     = "c3.4xlarge"
}

variable "c4xlarge" {
  description = "Instance Type c4.xlarge"
  default     = "c4.xlarge"
}

variable "c42xlarge" {
  description = "Instance Type c4.2xlarge"
  default     = "c4.2xlarge"
}

variable "c44xlarge" {
  description = "Instance Type c4.4xlarge"
  default     = "c4.4xlarge"
}

variable "c5xlarge" {
  description = "Instance Type c5.xlarge"
  default     = "c5.xlarge"
}

variable "c52xlarge" {
  description = "Instance Type c5.2xlarge"
  default     = "c5.2xlarge"
}

variable "c54xlarge" {
  description = "Instance Type c5.4xlarge"
  default     = "c5.4xlarge"
}

variable "i3xlarge" {
  description = "Instance Type i3.xlarge"
  default     = "i3.xlarge"
}

variable "i32xlarge" {
  description = "Instance Type i3.2xlarge"
  default     = "i3.2xlarge"
}

variable "i34xlarge" {
  description = "Instance Type i3.4xlarge"
  default     = "i3.4xlarge"
}

variable "r3xlarge" {
  description = "Instance Type r3.xlarge"
  default     = "r3.xlarge"
}

variable "r32xlarge" {
  description = "Instance Type r3.2xlarge"
  default     = "r3.2xlarge"
}

variable "r34xlarge" {
  description = "Instance Type r3.4xlarge"
  default     = "r3.4xlarge"
}

variable "r4xlarge" {
  description = "Instance Type r4.xlarge"
  default     = "r4.xlarge"
}

variable "r42xlarge" {
  description = "Instance Type r4.2xlarge"
  default     = "r4.2xlarge"
}

variable "r44xlarge" {
  description = "Instance Type r4.4xlarge"
  default     = "r4.4xlarge"
}
