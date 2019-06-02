output "kms_key_arn" {
  value = "${module.kms-rds-kong.kms_key_arn}"
}
