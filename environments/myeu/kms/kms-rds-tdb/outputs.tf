output "kms_key_arn" {
  value = "${module.kms-rds-tdb.kms_key_arn}"
}
