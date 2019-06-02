resource "aws_security_group" "client-terminator_elb_sg" {
  tags {
    Name = "${var.env}-${var.region}-client-terminator_elb"
  }

  name   = "${var.env}-${var.region}-client-terminator_elb"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_outside_world_80_to_client-terminator_elb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "ingress from outside world to client-terminator_elb on 80"
}

resource "aws_security_group_rule" "ingress_from_outside_world_443_tcp_to_client-terminator_elb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "ingress from outside world to client-terminator_elb on 443"
}

resource "aws_security_group_rule" "ingress_from_outside_world_443_udp_to_client-terminator_elb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "ingress from outside world to client-terminator_elb on 443 udp"
}

##Egres

resource "aws_security_group_rule" "egress_tcp_all_client-terminator_elb" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "egress some ports from client-terminator_elb"
}

resource "aws_security_group_rule" "egress_udp_all_client-terminator_elb" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "egress some udp ports from client-terminator_elb"
}

resource "aws_security_group_rule" "egress_self_all_client-terminator_elb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "egress all from client-terminator_elb to client-terminator_elb"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_client-terminator_elb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  description       = "egress VPC CIDR block"
}
