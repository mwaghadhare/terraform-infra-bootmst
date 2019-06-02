module "client-terminator-elb" {
  source = "../../../../modules/loadbalancers/ct-elb/"

  name                        = "${var.name}"
  route53_record              = "${var.route53_record}"
  route53_record_public       = "${var.route53_record_public}"
  subnets                     = ["${data.terraform_remote_state.vpc.public_subnets}"]
  security_groups             = ["${data.terraform_remote_state.vpc.client-terminator_elb_sg_id}"]
  internal                    = "${var.internal}"
  env                         = "${var.env}"
  region                      = "${var.region}"
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  instances                   = ["${split(",", data.terraform_remote_state.client-terminator.client-terminator_instance_ids)}"]
  topic_arn                   = "${var.topic_arn}"
  comparison_operator         = "${var.comparison_operator}"
  evaluation_periods          = "${var.evaluation_periods}"
  unhealthy_metric_name       = "${var.unhealthy_metric_name}"
  namespace                   = "${var.namespace}"
  period                      = "${var.period}"
  statistic                   = "${var.statistic}"
  unhealthy_threshold         = "${var.unhealthy_threshold}"
  requestcount_metric_name    = "${var.requestcount_metric_name}"
  requestcount_threshold      = "${var.requestcount_threshold}"
  http5xx_metric_name         = "${var.http5xx_metric_name}"
  http5xx_threshold           = "${var.http5xx_threshold}"
  latency_metric_name         = "${var.latency_metric_name}"
  latency_threshold           = "${var.latency_threshold}"

  health_check = [
    {
      target              = "HTTP:80/healthcheck"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

  log_bucket        = "my-${var.env}-elb-logs"
  log_bucket_prefix = "${var.name}"

  zone_id_public  = "${var.zone_id_public}"
  zone_id_private = "${var.zone_id_private}"
  tags            = "${var.name}-${var.env}"
}
