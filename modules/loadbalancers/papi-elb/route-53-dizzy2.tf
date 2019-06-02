resource "aws_route53_record" "route-53-public-dizzy2" {
  zone_id = "${var.zone_id_public}"
  name    = "dizzy2"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-dizzy2" {
  zone_id = "${var.zone_id_private}"
  name    = "dizzy2-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}