resource "aws_elb" "client-terminator" {
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  listener = [
    {
      instance_port     = 444
      instance_protocol = "tcp"
      lb_port           = 443
      lb_protocol       = "tcp"
    },
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    }
  ]

  #  access_logs  = ["${var.access_logs}"]
  access_logs {
    bucket        = "${var.log_bucket}"
    bucket_prefix = "${var.log_bucket_prefix}"
    interval      = 60
  }

  health_check = [
    {
      target              = "HTTP:80/healthcheck"
      interval            = 6
      healthy_threshold   = 2
      unhealthy_threshold = 2
      timeout             = 5
    }
  ]
  instances    = ["${var.instances}"]

  tags {
    Name = "${var.name}-${var.env}"
  }
}

resource "aws_load_balancer_policy" "client-terminator-ProxyProtocol-policy" {
  load_balancer_name = "${aws_elb.client-terminator.name}"
  policy_name        = "${var.name}-ProxyProtocol-policy"
  policy_type_name   = "ProxyProtocolPolicyType"
  policy_attribute{
    name = "ProxyProtocol"
    value = "true"
  }
}


resource "aws_load_balancer_backend_server_policy" "client-terminator-ProxyProtocol-backend"{
  load_balancer_name = "${aws_elb.client-terminator.name}"
  instance_port = 444
  policy_names = [
    "${aws_load_balancer_policy.client-terminator-ProxyProtocol-policy.policy_name}",
  ]
}
