variable "region" {
  default = "eu-central-1"
}

variable "lb_type" {
  default = "network"
}

variable "org" {
  default = "mysys"
}

variable "env" {
  default = "eu"
}

variable "name" {
  default = "redis-proxy"
}

variable "zone_id_public" {
  default = ""
}

variable "zone_id_private" {
  default = ""
}

variable "delay" {
  default = 45
}

variable "force_destroy_log_bucket" {
  default = false
}

variable "log_bucket_name" {
  default = "my-eu-elb-logs"
}

variable "alb_is_internal" {
  default = "true"
}
