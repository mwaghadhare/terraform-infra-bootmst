resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.name}-${format("%03d",count.index)}-${var.env}-sg"
  subnet_ids = ["${var.subnet_ids}"]
}
