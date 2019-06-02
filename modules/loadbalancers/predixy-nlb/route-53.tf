resource "aws_route53_record" "route-53-public-predixy-nlb" {
  zone_id = "${var.zone_id_public}"
  name    = "redis-proxy-location"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_alb.predixy_nlb.dns_name}"]
}

resource "aws_route53_record" "route-53-private-predixy-nlb" {
  zone_id = "${var.zone_id_private}"
  name    = "redis-proxy-location-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_alb.predixy_nlb.dns_name}"]
}
