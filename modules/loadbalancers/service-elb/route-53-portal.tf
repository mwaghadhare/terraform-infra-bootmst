resource "aws_route53_record" "route-53-public-portal" {
  zone_id = "${var.zone_id_public}"
  name    = "portal"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.service.dns_name}"]
}

resource "aws_route53_record" "route-53-private-portal" {
  zone_id = "${var.zone_id_private}"
  name    = "portal-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.service.dns_name}"]
}
