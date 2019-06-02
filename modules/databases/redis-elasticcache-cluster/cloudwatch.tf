# CW for Redis CPU-Usage

#resource "aws_cloudwatch_metric_alarm" "cpu-usage" {
#  count = "${var.desired_clusters}"

#   alarm_name          = "${var.name}-${var.env}-00${count.index + 1}-CPU-Utilization"
#   alarm_description   = "Redis cluster CPU utilization"
#   comparison_operator = "${var.comparison_operator}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   metric_name         = "${var.cpu_metric_name}"
#   namespace           = "${var.namespace}"
#   period              = "${var.period}"
#   statistic           = "${var.statistic}"
#   threshold           = "${var.threshold}"

#   dimensions {
#     CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
#   }

#   alarm_actions = ["${var.common_topic_arn}"]
# }

# # CW for Redis memory
# resource "aws_cloudwatch_metric_alarm" "cache_memory" {
#   count = "${var.desired_clusters}"

#   alarm_name          = "${var.name}-${var.env}-00${count.index + 1}-Memory-Utilization"
#   alarm_description   = "Redis cluster Memory utilization"
#   comparison_operator = "${var.comparison_operator_cachmem}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   metric_name         = "${var.memory_metric_name}"
#   namespace           = "${var.namespace}"
#   period              = "${var.period}"
#   statistic           = "${var.statistic}"
#   threshold           = "${var.redis_memory_threshold}"

#   dimensions {
#     CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
#   }

#   alarm_actions = ["${var.common_topic_arn}"]
# }

# #CW for Redis ReplicationLag

# resource "aws_cloudwatch_metric_alarm" "cache_replicationlag" {
#   count = "${var.desired_clusters}"

#   alarm_name          = "${var.name}-${var.env}-00${count.index + 1}-ReplicationLag"
#   alarm_description   = "Redis cluster replication lag"
#   comparison_operator = "${var.comparison_operator}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   metric_name         = "${var.replicationlag_metric_name}"
#   namespace           = "${var.namespace}"
#   period              = "${var.period}"
#   statistic           = "${var.statistic}"
#   threshold           = "${var.replicationlag_threshold}"

#   dimensions {
#     CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
#   }

#   alarm_actions = ["${var.common_topic_arn}"]
# }

# #CW for Redis Swap Usage

# resource "aws_cloudwatch_metric_alarm" "cache_swapusage" {
#   count = "${var.desired_clusters}"

#   alarm_name          = "${var.name}-${var.env}-00${count.index + 1}-SwapUsage"
#   alarm_description   = "Redis cluster swap Memory utilization"
#   comparison_operator = "${var.comparison_operator}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   metric_name         = "${var.swapmem_metric_name}"
#   namespace           = "${var.namespace}"
#   period              = "${var.period}"
#   statistic           = "${var.statistic}"
#   threshold           = "${var.swapmem_threshold}"

#   dimensions {
#     CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
#   }

#   alarm_actions = ["${var.common_topic_arn}"]
# }

# #CW for Redis Currconnection

# resource "aws_cloudwatch_metric_alarm" "cache_currconnection" {
#   count               = "${var.desired_clusters}"
#   alarm_name          = "${var.name}-${var.env}-00${count.index + 1}-Currconnection"
#   alarm_description   = "Redis cluster current connection"
#   comparison_operator = "${var.comparison_operator}"
#   evaluation_periods  = "${var.evaluation_periods}"
#   metric_name         = "${var.currconnection_metric_name}"
#   namespace           = "${var.namespace}"
#   period              = "${var.period}"
#   statistic           = "${var.statistic}"
#   threshold           = "${var.currconnection_threshold}"

#   dimensions {
#     CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
#   }

#   alarm_actions = ["${var.common_topic_arn}"]
# }
