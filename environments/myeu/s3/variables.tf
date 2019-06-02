variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "eu"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "zone_id_public" {
  default = ""
}

variable "zone_id_private" {
  default = ""
}

variable "aws_account_id" {
  default = ""
}

variable "user" {
  default = "ubuntu"
}

variable "root_volume_type" {
  description = "The root volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The root volume size default is 8"
  default     = "25"
}

variable "root_delete_on_termination" {
  description = "Boolean to make sure we need to delete root volume after termination or not?"
  default     = "false"
}

variable "device_name" {
  description = "The device name for the EBS storage either data or opt"
  default     = "/dev/sdb"
}

variable "volume_type" {
  description = "The data or opt volume type for the isntance like gp2, piops"
  default     = "gp2"
}

variable "volume_size" {
  description = "The data or opt volume size default is 1 GB as by AWS and go upto 16TB"
  default     = "100"
}

variable "delete_on_termination" {
  description = "Boolean to make sure we need to delete opt ro data volume after termination or not?"
  default     = "false"
}

variable "service_name" {
  description = "AWS VPC service endpoint"
  default     = "com.amazonaws.eu-central-1.s3"
}

variable "aws_principal" {
  default = "arn:aws:iam::054676820928:root"
}

variable "iam_role" {
  default = "terraform-create-role"
}

variable "domain" {
  default = "my.com"
}

variable "chef_fqdn" {
  description = "Chef server FQDN"
  default     = "https://chef-server-000-eu.my.pvt/organizations/mysys-eu"
}

