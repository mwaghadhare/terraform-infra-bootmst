resource "aws_route53_record" "route-53-public-birdcage" {
  zone_id = "${var.zone_id_public}"
  name    = "birdcage"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}

resource "aws_route53_record" "route-53-private-birdcage" {
  zone_id = "${var.zone_id_private}"
  name    = "birdcage-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.papi.dns_name}"]
}