variable "certificate_name" {
  description = "Name of the ACM certificate."
  type        = "string"
  default     = "API/Poertal SSL Certificate"
}

variable "env" {
  description = "Environment this ACM certificate belongs to."
  type        = "string"
  default     = "eu"
}

variable "region" {
  default = "eu-central-1"
}

variable "description" {
  description = "ACM certificate for api.myeu.com"
  type        = "string"
  default     = "ACM certificate for api.myeu.com"
}

variable "domain_name" {
  description = "Domain name the certificate is issued for."
  type        = "string"
  default     = "api.myeu.com"
}

variable "validation_method" {
  description = "Certificate validation method. Possible values: DNS, EMAIL."
  type        = "string"
  default     = "DNS"
}

variable "zone_id_public" {
  description = "Need for DNS validation, hosted zone name where record validation will be stored."
  type        = "string"
  default     = ""
}

variable "subject_alternative_names" {
  description = "Alternate dns name"
  type        = "list"
  default     = ["portal.myeu.com"]
}
