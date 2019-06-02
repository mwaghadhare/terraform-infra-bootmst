variable "namespace" {
  type        = "string"
  description = "Namespace"
}

variable "env" {
  type        = "string"
  description = "Testpad"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "deletion_window_in_days" {
  default     = 30
  description = "Duration in days after which the key is deleted after destruction of the resource"
}

variable "enable_key_rotation" {
  default     = "true"
  description = "Specifies whether key rotation is enabled"
}

variable "description" {
  type        = "string"
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"
}
