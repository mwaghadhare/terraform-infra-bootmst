resource "aws_route53_record" "route-53-public-wlc" {
  zone_id = "${var.zone_id_public}"
  name    = "wlc"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-wlc" {
  zone_id = "${var.zone_id_private}"
  name    = "wlc-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}