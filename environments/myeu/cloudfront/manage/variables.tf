variable "region" {
  default = "eu-west-1"
}

variable "env" {
  default = "eu"
}

variable "certificate_arn" {
  description = "Existing certificate arn."
  default     = "arn:aws:acm:us-east-1:888xxxxxx:certificate/667674xxxxx-xxxxx-xxxx788"
}

variable "enabled" {
  default = "true"
}

variable "bucket_name" {
  default = "manage.myeu.com"
}

variable "compress" {
  default = "true"
}

variable "ipv6_enabled" {
  default = "false"
}

variable "comment" {
  default = "Managed by Terraform"
}

variable "log_include_cookies" {
  default = "false"
}

variable "log_bucket" {
  default = "cloudfront-logging-eu"
}

variable "log_prefix" {
  default = "cf_logs"
}

variable "price_class" {
  default = "PriceClass_All"
}

variable "allowed_methods" {
  type    = "list"
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  type    = "list"
  default = ["GET", "HEAD"]
}

variable "min_ttl" {
  default = "0"
}

variable "max_ttl" {
  default = "31536000"
}

variable "default_ttl" {
  default = "60"
}

variable "ssl_support_method" {
  default = "sni-only"
}

variable "root_object" {
  default = "index.html"
}

variable "protocol_version" {
  default = "TLSv1.2_2018"
}

variable "origin_http_port" {
  description = "(Required) - The HTTP port the custom origin listens on"
  default     = "80"
}

variable "origin_https_port" {
  description = "(Required) - The HTTPS port the custom origin listens on"
  default     = "443"
}

variable "origin_protocol_policy" {
  description = "(Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
  default     = "http-only"
}

variable "origin_ssl_protocols" {
  description = "(Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS"
  type        = "list"
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "origin_keepalive_timeout" {
  description = "(Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = "30"
}

variable "origin_read_timeout" {
  description = "(Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = "5"
}

variable "query_string" {
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default     = "true"
}

variable "cookies" {
  description = "The forwarded values cookies that specifies how CloudFront handles cookies (maximum on"
  default     = "none"
}

variable "logging_bucket" {
  default = "cloudfront-logging-eu.s3.amazonaws.com"
}

variable "logging_bucket_prefix" {
  default = "cf-log"
}

variable "zone_id_public" {
  default = ""
}

variable "route53" {
  default = "manage"
}

variable "viewer_protocol_policy" {
  description = ""
  default     = "redirect-to-https"
}
