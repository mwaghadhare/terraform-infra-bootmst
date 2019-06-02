resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.domain_name}"
  validation_method         = "${var.validation_method}"
  subject_alternative_names = "${var.subject_alternative_names}"

  tags = {
    Name        = "${var.certificate_name}"
    Environment = "${var.env}"
    Description = "${var.description}"
    ManagedBy   = "terraform"
  }
}

resource "aws_route53_record" "cert" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${var.hosted_zone_name}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
  count   = "${var.validation_method == "DNS" ? 1 : 0}"
}

resource "aws_route53_record" "cert_validation_alt1" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_type}"
  zone_id = "${var.hosted_zone_name}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.1.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "dns_validation" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  validation_record_fqdns = ["${aws_route53_record.cert.fqdn}",
    "${aws_route53_record.cert_validation_alt1.fqdn}",
  ]

  count = "${var.validation_method == "DNS" ? 1 : 0}"
}

resource "aws_acm_certificate_validation" "email_validation" {
  certificate_arn = "${aws_acm_certificate.cert.arn}"
  count           = "${var.validation_method == "EMAIL" ? 1 : 0}"
}
