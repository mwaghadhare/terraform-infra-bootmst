resource "aws_elb" "ep-terminator" {
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  listener = ["${var.listeners}"]

  #  access_logs  = ["${var.access_logs}"]
  access_logs {
    bucket        = "${var.log_bucket}"
    bucket_prefix = "${var.log_bucket_prefix}"
    interval      = 60
  }

  health_check = ["${var.health_check}"]
  instances    = ["${var.instances}"]

  tags {
    Name = "${var.name}-${var.env}"
  }
}


resource "aws_load_balancer_policy" "ep-terminator-ProxyProtocol-policy" {
  load_balancer_name = "${aws_elb.ep-terminator.name}"
  policy_name        = "${var.name}-ProxyProtocol-policy"
  policy_type_name   = "ProxyProtocolPolicyType"
  policy_attribute{
    name = "ProxyProtocol"
    value = "true"
  }
}

resource "aws_load_balancer_backend_server_policy" "ep-terminator-ProxyProtocol-backend"{
  load_balancer_name = "${aws_elb.ep-terminator.name}"
  instance_port = 444
  policy_names = [
    "${aws_load_balancer_policy.ep-terminator-ProxyProtocol-policy.policy_name}",
  ]
}
