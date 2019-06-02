resource "aws_route53_record" "route-53-public-kong" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.route53_record}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.kong.dns_name}"]
}

resource "aws_route53_record" "route-53-private-kong" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.route53_record}-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.kong.dns_name}"]
}
