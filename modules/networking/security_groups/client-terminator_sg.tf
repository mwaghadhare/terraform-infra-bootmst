resource "aws_security_group" "client-terminator_sg" {
  tags {
    Name = "${var.env}-${var.region}-client-terminator"
  }

  name   = "${var.env}-${var.region}-client-terminator"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_client-terminator_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress from bastion to client-terminator on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_client_terminator_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress from openvpn to client on port 22"
}

resource "aws_security_group_rule" "ingress_from_outside_world_80_to_client-terminator" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "ingress from outside world to client-terminator on 80"
}

resource "aws_security_group_rule" "ingress_from_outside_world_443_tcp_to_client-terminator" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "ingress from outside world to client-terminator on 443"
}

resource "aws_security_group_rule" "ingress_from_outside_world_443_udp_to_client-terminator" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "ingress from outside world to client-terminator on 443 UDP"
}

resource "aws_security_group_rule" "ingress_all_from_client-terminator_elb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.client-terminator_elb_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress all traffic from client terminator elb"
}

resource "aws_security_group_rule" "ingress_self_all_client-terminator" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "ingress from client-terminator to client-terminator on all ports"
}

####

resource "aws_security_group_rule" "ingress_9110_from_openvpn_to_client_terminators" {
  type                     = "ingress"
  from_port                = 9110
  to_port                  = 9110
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 9110 from VPN"
}

resource "aws_security_group_rule" "ingress_45431_from_ep_terminator_tcp_to_client_terminators" {
  type                     = "ingress"
  from_port                = 45431
  to_port                  = 45431
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 45431 from ep terminator tcp"
}

resource "aws_security_group_rule" "ingress_45431_from_mesos-slaves_tcp_to_client_terminators" {
  type                     = "ingress"
  from_port                = 45431
  to_port                  = 45431
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 45431 from mesos slaves tcp"
}

resource "aws_security_group_rule" "ingress_45431_from_ep_terminator_udp_to_client_terminators" {
  type                     = "ingress"
  from_port                = 45431
  to_port                  = 45431
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 45431 from ep terminator udp"
}

resource "aws_security_group_rule" "ingress_45431_from_mesos-slaves_udp_to_client_terminators" {
  type                     = "ingress"
  from_port                = 45431
  to_port                  = 45431
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 45431 from mesos slaves udp"
}

resource "aws_security_group_rule" "ingress_45431_from_openvpn_to_client_terminators" {
  type                     = "ingress"
  from_port                = 45431
  to_port                  = 45431
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 45431 from openvpn"
}

resource "aws_security_group_rule" "ingress_9090_from_mesos-slaves_to_client_terminators" {
  type                     = "ingress"
  from_port                = 9090
  to_port                  = 9090
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 9090 from mesos slaves"
}

resource "aws_security_group_rule" "ingress_13411_from_mesos-slaves_to_client_terminators" {
  type                     = "ingress"
  from_port                = 13411
  to_port                  = 13411
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.client-terminator_sg.id}"
  description              = "ingress 13411 from mesos slaves"
}

##Egress

resource "aws_security_group_rule" "egress_tcp_all_client-terminator" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "egress some ports from client-terminator"
}

resource "aws_security_group_rule" "egress_udp_all_client-terminator" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "egress some udp ports from client-terminator"
}

resource "aws_security_group_rule" "egress_self_all_client-terminator" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "egress all from client-terminator to client-terminator"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_client-terminator" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.client-terminator_sg.id}"
  description       = "egress VPC CIDR block"
}
