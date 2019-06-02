resource "aws_elb" "service" {
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.internal}"
  security_groups = ["${var.security_groups}"]

  cross_zone_load_balancing   = "${var.cross_zone_load_balancing}"
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"

  listener = ["${var.listener}"]

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
