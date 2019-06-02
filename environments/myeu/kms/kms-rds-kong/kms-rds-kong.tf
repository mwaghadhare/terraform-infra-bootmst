module "kms-rds-kong" {
  source         = "../../../../modules/kms/"
  region         = "${var.region}"
  env            = "${var.env}"
  key_identifier = "${var.key_identifier}"
}
