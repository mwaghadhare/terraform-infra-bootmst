resource "aws_alb" "predixy_nlb" {
  name            = "${var.name}"
  subnets         = ["${var.subnets}"]
#  security_groups = ["${var.alb_security_groups}"]
  internal        = "${var.alb_is_internal}"
  tags {           
    Name = "${var.name}-${var.env}"
       }
  load_balancer_type = "${var.lb_type}"
  access_logs {
    bucket  = "${var.log_bucket_name}"
    prefix  = "${var.log_location_prefix}"
    enabled = "${var.enable_logging}"
  }

#  depends_on = ["aws_s3_bucket.log_bucket"]
}

#resource "aws_s3_bucket" "log_bucket" {
#  bucket        = "${var.log_bucket_name}"
#  force_destroy = "${var.force_destroy_log_bucket}"
#  count         = "${var.create_log_bucket ? 1 : 0}"
#  tags          = "${var.log_bucket_name}"

#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#           "Principal": {
#                "AWS": "arn:aws:iam::054676820928:root"
#           },
#           "Action" : "s3:PutObject",
#           "Resource":[
#               "arn:aws:s3:::${var.log_bucket_name}/*"
#           ]
#       }
#           ]
#       }
#EOF
#}

resource "aws_alb_target_group" "target_group" {
  name                 = "${var.name}-tg"
  port                 = "${var.backend_port}"
  protocol             = "${upper(var.backend_protocol)}"
  vpc_id               = "${var.vpc_id}"
  deregistration_delay = "${var.delay}"

  health_check {
    interval            = "${var.health_check_interval}"
#    path                = "${var.health_check_path}"
    port                = "${var.health_check_port}"
    healthy_threshold   = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
#    timeout             = "${var.health_check_timeout}"
    protocol            = "${var.backend_protocol}"
 #   matcher             = "${var.health_check_matcher}"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "${var.cookie_duration}"
    enabled         = "${ var.cookie_duration == 1 ? false : true}"
  }

 # tags = "${var.name}-${var.env}-tg"
}

resource "aws_alb_listener" "frontend_6379" {
  load_balancer_arn = "${aws_alb.predixy_nlb.arn}"
  port              = "6379"
  protocol          = "TCP"
  count             = "${contains(var.alb_protocols, "TCP") ? 1 : 0}"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "frontend_7617" {
  load_balancer_arn = "${aws_alb.predixy_nlb.arn}"
  port              = "7617"
  protocol          = "TCP"
#  certificate_arn   = "${var.certificate_arn}"
#  ssl_policy        = "${var.security_policy}"
  count             = "${contains(var.alb_protocols, "TCP") ? 1 : 0}"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}
