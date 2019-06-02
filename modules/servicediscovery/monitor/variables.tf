variable "instances" {
  type = "list"
}

variable "role_name" {
  description = "Name of the zookeeper role (for ex. zookeeper_env)"
  default     = ""
}

variable "env" {}

variable "region" {}

variable "number_of_instances" {}

variable "bastion_user" {
  description = "bastion user"
  default     = "ubuntu"
}

variable "bastion_host" {
  description = "Bastion Host to get the SSH connection and bootstrap the server"
  default     = ["mystandardqueue1"]
}
