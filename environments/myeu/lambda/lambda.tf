module "lambda" {
  source = "../../../../modules/lambda/"
  zone_id_public  = "${var.zone_id_public}"
  zone_id_private = "${var.zone_id_private}"
  aws_account_id  = "${var.aws_account_id}"
}
