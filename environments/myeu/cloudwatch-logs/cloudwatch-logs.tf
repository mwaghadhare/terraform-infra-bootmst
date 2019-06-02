module "cloudwatch" {
  source = "../../../modules/cloudwatch-logs/"
  env    = "${var.env}"
}
