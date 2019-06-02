resource "aws_route53_record" "route-53-public-marvis" {
  zone_id = "${var.zone_id_public}"
  name    = "marvis"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-marvis" {
  zone_id = "${var.zone_id_private}"
  name    = "marvis-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}
