module "kong-acm" {
  source                    = "../../../../modules/certificates/acm/"
  domain_name               = "${var.domain_name}"
  hosted_zone_name          = "${var.zone_id_public}"
  validation_method         = "${var.validation_method}"
  certificate_name          = "${var.certificate_name}"
  env                       = "${var.env}"
  description               = "${var.description}"
  subject_alternative_names = "${var.subject_alternative_names}"
}
