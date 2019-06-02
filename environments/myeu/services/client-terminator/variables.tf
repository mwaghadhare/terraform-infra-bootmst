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
  default = "client-terminator"
}

variable "number_of_instances" {
  default = "2"
}

#variable "ami_id" {
#  default = "ami-839eab68"
#}

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

#variable "data_device_name" {
#  description = "The device name for the EBS storage either data or opt"
#  default     = "/dev/sdc"
#}

#variable "data_volume_type" {
#  description = "The data or opt volume type for the isntance like gp2, piops"
#  default     = "gp2"
#}

#variable "data_volume_size" {
#  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
#  default     = "100"
#}

#variable "data_delete_on_termination" {
#  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
#  default     = "false"
#}

#variable "opt_device_name" {
#  description = "The device name for the EBS storage either data or opt"
#  default     = "/dev/sdb"
#}

#variable "opt_volume_type" {
#  description = "The data or opt volume type for the isntance like gp2, piops"
#  default     = "gp2"
#}

#variable "opt_volume_size" {
#  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
#  default     = "15"
#}

#variable "opt_delete_on_termination" {
#  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
#  default     = "false"
#}

variable "org" {
  default = "mysys"
}

variable "kms_key_id" {
  description = "KMS Key ID to allow for terminator"
}

variable "chef_fqdn" {
  description = "Chef server FQDN"
  default     = "https://chef-server-000-eu.my.pvt/organizations/mysys-eu"
}
