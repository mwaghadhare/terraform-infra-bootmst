variable "certificate_name" {
  description = "Name of the ACM certificate."
  type        = "string"
}

variable "env" {
  description = "Environment this ACM certificate belongs to."
  type        = "string"
}

variable "description" {
  description = "Free form description of this ACM certificate."
  type        = "string"
}

variable "domain_name" {
  description = "Domain name the certificate is issued for."
  type        = "string"
}

variable "validation_method" {
  description = "Certificate validation method. Possible values: DNS, EMAIL."
  type        = "string"
}

variable "hosted_zone_name" {
  description = "Need for DNS validation, hosted zone name where record validation will be stored."
  type        = "string"
}

variable "subject_alternative_names" {
  description = "Aleternate Domain name for the certificate"
  type        = "list"
}
