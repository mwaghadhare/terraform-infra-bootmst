resource "aws_route53_record" "route-53-public-apollo" {
  zone_id = "${var.zone_id_public}"
  name    = "apollo"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-apollo" {
  zone_id = "${var.zone_id_private}"
  name    = "apollo-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}
