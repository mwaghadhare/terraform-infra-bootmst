variable "region" {
  default = "eu-west-1"
}

variable "env" {
  default = "myeu"
}

variable "address" {
  default = "mesos-master-000-myeu.pvt:8500"
}

variable "datacenter" {
  default = "myeu-eu-west-1"
}

variable "papi_database" {
  default = "postgres-000-myeu.pvt"
}

variable "papi_host" {
  default = "redis-000-myeu.pvt"
}
