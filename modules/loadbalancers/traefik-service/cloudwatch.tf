resource "aws_cloudwatch_metric_alarm" "traefik-service_status_check" {
  alarm_name          = "StatusCheck-traefik-service-${format("%03d",count.index)}-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"
  count               = "${var.number_of_instances}"

  dimensions {
    InstanceId = "${element(aws_instance.traefik-service.*.id, count.index)}"
  }

  alarm_description = "This metric monitor status check"
  alarm_actions     = ["${var.status_check_arn}"]
}

resource "aws_cloudwatch_metric_alarm" "traefik-service" {
  alarm_name          = "CPUUtilization-traefik-service-${format("%03d",count.index)}-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.cpu_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.cpu_statistic}"
  threshold           = "${var.cpu_threshold}"
  count               = "${var.number_of_instances}"

  dimensions {
    InstanceId = "${element(aws_instance.traefik-service.*.id, count.index)}"
  }

  alarm_description = "This metric monitor ec2 cpu utilization"
  alarm_actions     = ["${var.cpu_topic_arn}"]
}

