output "acm_certificate_arn" {
  description = "arn of acm certificate"
  value       = "${aws_acm_certificate.cert.arn}"
}

output "acm_certificate_dns_validation_record" {
  description = "record which is used to validate acm certificate"
  value       = "${element(concat(aws_route53_record.cert.*.name, list("")), 0)}"
}
