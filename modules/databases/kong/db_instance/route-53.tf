resource "aws_route53_record" "route-53-private" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.route53_record}-${var.env}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${aws_db_instance.rds.address}"]
}
