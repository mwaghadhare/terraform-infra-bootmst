resource "aws_route53_record" "route-53-public-papi" {
  zone_id = "${var.zone_id_public}"
  name    = "papi"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-papi" {
  zone_id = "${var.zone_id_private}"
  name    = "papi-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}
