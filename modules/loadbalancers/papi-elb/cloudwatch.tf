# CW ELB metrics for unhealthy host
resource "aws_cloudwatch_metric_alarm" "papi_status_check" {
  alarm_name          = "UnhealthyHostCount-papi-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"

  dimensions {
    LoadBalancerName = "${aws_elb.papi.name}"
  }

  alarm_description = "This metric monitor unhealthy host count"
  alarm_actions     = ["${var.topic_arn}"]
}

# CW ELB metrics for request count
resource "aws_cloudwatch_metric_alarm" "elb_requestcount_check" {
  alarm_name          = "RequestCount-papi-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.requestcount_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.requestcount_threshold}"

  dimensions {
    LoadBalancerName = "${aws_elb.papi.name}"
  }

  alarm_description = "This metric monitor Request count"
  alarm_actions     = ["${var.topic_arn}"]
}

# CW ELB metrics for HTTPCode_ELB_5XX_Count

resource "aws_cloudwatch_metric_alarm" "elb_http5xx_check" {
  alarm_name          = "http5xx-papi-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.http5xx_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.http5xx_threshold}"

  dimensions {
    LoadBalancerName = "${aws_elb.papi.name}"
  }

  alarm_description = "This metric monitor httpcode 5xx"
  alarm_actions     = ["${var.topic_arn}"]
}

#CW ELB metrics for latency

resource "aws_cloudwatch_metric_alarm" "elb_latency_check" {
  alarm_name          = "latency-papi-${var.env}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "${var.latency_metric_name}"
  namespace           = "${var.namespace}"
  period              = "${var.period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.latency_threshold}"

  dimensions {
    LoadBalancerName = "${aws_elb.papi.name}"
  }

  alarm_description = "This metric monitor latency"
  alarm_actions     = ["${var.topic_arn}"]
}

