resource "aws_route53_record" "route-53-public" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.service.dns_name}"
    zone_id                = "${aws_elb.service.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "route-53-private" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.name}-${var.env}"
  type    = "A"

  alias {
    name                   = "${aws_elb.service.dns_name}"
    zone_id                = "${aws_elb.service.zone_id}"
    evaluate_target_health = true
  }
}
