resource "aws_route53_record" "route-53-public-client-terminator" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.route53_record_public}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.client-terminator.dns_name}"]
}

resource "aws_route53_record" "route-53-private-client-terminator" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.route53_record}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.client-terminator.dns_name}"]
}
