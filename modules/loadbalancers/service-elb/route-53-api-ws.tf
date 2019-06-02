resource "aws_route53_record" "route-53-public-api-ws" {
  zone_id = "${var.zone_id_public}"
  name    = "api-ws"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.service.dns_name}"]
}

resource "aws_route53_record" "route-53-private-api-ws" {
  zone_id = "${var.zone_id_private}"
  name    = "api-ws-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_elb.service.dns_name}"]
}
