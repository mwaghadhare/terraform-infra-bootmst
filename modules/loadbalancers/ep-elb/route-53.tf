resource "aws_route53_record" "route-53-public-ep-terminator" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.route53_record_public}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.ep-terminator.dns_name}"]
}

resource "aws_route53_record" "route-53-private-ep-terminator" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.route53_record}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.ep-terminator.dns_name}"]
}
