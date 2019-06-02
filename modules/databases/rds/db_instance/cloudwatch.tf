# Adding RDS db CPU related alerts

resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name        = "${var.name}-${var.env}"
  alarm_description = "${var.name} CPU utilization"

  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name_cpu}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.cpu_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.rds.id}"
  }

  alarm_description = "This metric monitor ec2 cpu utilization"
  alarm_actions     = ["${var.common_arn}"]
}

# Adding RDS db connections related alerts 

resource "aws_cloudwatch_metric_alarm" "db_connection" {
  alarm_name        = "${var.name}-DatabaseServerDBConnection-${var.env}"
  alarm_description = "${var.name} Database DB Connection"

  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name_dbconn}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.dbconn_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.rds.id}"
  }

  alarm_description = "This metric monitor RDS DB connection"
  alarm_actions     = ["${var.common_arn}"]
}

# Adding RDS DB storage related alerts

resource "aws_cloudwatch_metric_alarm" "db_storgae_alert" {
  alarm_name        = "${var.name}-Database-storage-alert-${var.env}"
  alarm_description = "${var.name} Database storage alarm"

  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name_dbstorage}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.dbstorage_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.rds.id}"
  }

  alarm_description = "This metric monitor RDS DB Storage "
  alarm_actions     = ["${var.common_arn}"]
}

# Adding RDS free memory related alerts

resource "aws_cloudwatch_metric_alarm" "db_memory_alert" {
  alarm_name        = "${var.name}-Database-memory-alert-${var.env}"
  alarm_description = "${var.name} Database memory alarm"

  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name_dbmemory}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.dbmemory_threshold}"

  dimensions {
    DBInstanceIdentifier = "${aws_db_instance.rds.id}"
  }

  alarm_description = "This metric monitor RDS DB Memory "
  alarm_actions     = ["${var.common_arn}"]
}
