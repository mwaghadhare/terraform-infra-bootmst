variable "enabled" {
  default = ""
}

variable "ipv6_enabled" {
  default = ""
}

variable "comment" {
  default = ""
}

variable "price_class" {
  default = ""
}

variable "root_object" {
  default = ""
}

variable "log_bucket" {
  default = ""
}

variable "max_ttl" {
  default = ""
}

variable "default_ttl" {
  default = ""
}

variable "min_ttl" {
  default = ""
}

variable "viewer_protocol_policy" {
  default = ""
}

variable "allowed_methods" {
  default = ""
}

variable "compress" {
  default = ""
}

variable "cached_methods" {
  default = ""
}

variable "log_prefix" {
  default = ""
}

variable "bucket_name" {
  default = ""
}

variable "ssl_support_method" {
  default = ""
}

variable "certificate_arn" {
  default = ""
}

variable "protocol_version" {
  default = ""
}

variable "log_include_cookies" {
  default = ""
}

variable "env" {
  default = ""
}

variable "origin_http_port" {
  description = "(Required) - The HTTP port the custom origin listens on"
  default     = ""
}

variable "origin_https_port" {
  description = "(Required) - The HTTPS port the custom origin listens on"
  default     = ""
}

variable "origin_protocol_policy" {
  description = "(Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
  default     = ""
}

variable "origin_ssl_protocols" {
  type = "list"
}

variable "origin_keepalive_timeout" {
  description = "(Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = ""
}

variable "origin_read_timeout" {
  description = "(Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = ""
}

variable "query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default     = ""
}

variable "cookies" {
  description = "The forwarded values cookies that specifies how CloudFront handles cookies (maximum on"
  default     = ""
}

variable "logging_bucket" {
  default = "'"
}

variable "logging_bucket_prefix" {
  default = ""
}

variable "zone_id_public" {
  default = ""
}

variable "region" {
  default = ""
}

variable "route53" {
  default = ""
}
