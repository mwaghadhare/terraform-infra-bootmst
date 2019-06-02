variable "region" {
  default = "eu-central-1"
}

variable "env" {
  default = "qadeer"
}

variable "key_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
}
