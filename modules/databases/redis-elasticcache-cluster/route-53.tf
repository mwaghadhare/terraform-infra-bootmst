# resource "aws_route53_record" "route-53-public" {
#   zone_id = "${var.zone_id_public}"
#   name    = "${var.route53_record}"
#   type    = "CNAME"
#   ttl     = "60"
#   records = ["${aws_elasticache_replication_group.redis.primary_endpoint_address}"]
# }

# resource "aws_route53_record" "route-53-private" {
#   zone_id = "${var.zone_id_private}"
#   name    = "${var.route53_record}-${var.env}"
#   type    = "CNAME"
#   ttl     = "60"
#   records = ["${aws_elasticache_replication_group.redis.primary_endpoint_address}"]
# }
