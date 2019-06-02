resource "aws_route53_record" "route-53-cloudfront" {
  zone_id = "${var.zone_id_public}"
  name    = "${var.route53}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id }"
    evaluate_target_health = false
  }
}
