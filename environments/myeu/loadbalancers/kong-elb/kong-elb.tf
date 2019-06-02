module "kong-elb" {
  source = "../../../../modules/loadbalancers/kong-elb/"

  name = "${var.name}"

  subnets                     = ["${data.terraform_remote_state.vpc.public_subnets}"]
  security_groups             = ["${data.terraform_remote_state.vpc.kong_elb_sg_id}"]
  internal                    = "${var.internal}"
  route53_record              = "${var.route53_record}"
  env                         = "${var.env}"
  region                      = "${var.region}"
  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  instances                   = ["${split(",", data.terraform_remote_state.kong.kong_instance_ids)}"]
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

  listener = [
    {
      instance_port      = "8443"
      instance_protocol  = "HTTPS"
      lb_port            = "443"
      lb_protocol        = "HTTPS"
      ssl_certificate_id = "arn:aws:acm:eu-central-1:8888xxxxx:certificate/1fca3617-57be-48d4-8a1a-2794b3692c44"
    },
  ]

  health_check = [
    {
      target              = "HTTP:8001/status"
      interval            = 30
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    },
  ]

  log_bucket        = "my-${var.env}-elb-logs"
  log_bucket_prefix = "${var.name}"

  #access_logs = [
  #  {
  #    bucket = "my-${var.env}-kong-elb-logs"
  #  },
  #]

  zone_id_public  = "${var.zone_id_public}"
  zone_id_private = "${var.zone_id_private}"
  tags            = "${var.name}-${var.env}"
}
