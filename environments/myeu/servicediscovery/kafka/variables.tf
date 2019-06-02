variable "env" {
  default = "eu"
}

variable "role_name" {
  default = "consul_agent_eu"
}

variable "region" {
  default = "eu-central-1"
}

variable "instances" {
  description = "List of instances ID"
  type        = "list"
  default     = []
}

variable "number_of_instances" {
  description = "Number of instances"
  default     = 5
}

variable "user" {
  default = "ubuntu"
}
