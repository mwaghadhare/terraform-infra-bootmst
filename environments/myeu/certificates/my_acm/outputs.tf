output "certificate_arn" {
  value = "${module.kong-acm.acm_certificate_arn}"
}

output "validation_record" {
  value = "${module.kong-acm.acm_certificate_dns_validation_record}"
}
