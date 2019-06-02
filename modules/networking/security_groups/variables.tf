variable "vpc_id" {}
variable "env" {}
variable "region" {}
variable "bastion_sg_id" {}
variable "cidr" {
  type  = "list"
}

variable "all_egress_tcp" {
  type    = "list"
  default = ["80", "443", "2181"]
}

variable "all_egress_udp" {
  type    = "list"
  default = ["123", "53"]
}

variable "all_egress_bastion_tcp" {
  type    = "list"
  default = ["22", "80", "443"]
}

variable "all_egress_praxis_tcp" {
  type    = "list"
  default = ["22", "80", "443"]
}

variable "all_egress_predixy_tcp" {
  type    = "list"
  default = ["6379", "7617"]
}

variable "all_egress_ap-qa_tcp" {
  type    = "list"
  default = ["22", "80", "443"]
}
