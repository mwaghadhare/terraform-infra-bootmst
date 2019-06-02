resource "aws_security_group" "kong_sg" {
  tags {
    Name = "${var.env}-${var.region}-kong"
  }

  name   = "${var.env}-${var.region}-kong"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_kong_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.kong_sg.id}"
  description              = "ingress from bastion to kong on port 22"
}

resource "aws_security_group_rule" "ingress_8443_from_kong_elb_to_kong" {
  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kong_elb_sg.id}"
  security_group_id        = "${aws_security_group.kong_sg.id}"
  description              = "ingress 8443 traffic from kong elb"
}

resource "aws_security_group_rule" "ingress_self_all_kong" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "ingress from kong to kong on all ports"
}

##Egres

resource "aws_security_group_rule" "egress_tcp_all_kong" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "egress some ports from kong sg"
}

resource "aws_security_group_rule" "egress_udp_all_kong" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "egress some udp ports from kong"
}

resource "aws_security_group_rule" "egress_self_all_kong" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "egress all from kong to kong"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_kong" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "egress VPC CIDR block"
}
