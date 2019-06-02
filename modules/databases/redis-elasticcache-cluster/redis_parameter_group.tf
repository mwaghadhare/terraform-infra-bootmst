resource "aws_elasticache_parameter_group" "redis_parameter_group" {
  name   = "${var.name}-${format("%03d",count.index)}-${var.env}-pg"
  family = "redis4.0"

  parameter {
    
    name = "cluster-enabled"
    value = "yes"   
  }
}