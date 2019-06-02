resource "aws_security_group" "load-generator_sg" {
  tags {
    Name = "${var.env}-${var.region}-load-generator"
  }

  name   = "${var.env}-${var.region}-load-generator"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_load-generator_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.load-generator_sg.id}"
  description              = "ingress from bastion to load-generator on 22"
}



resource "aws_security_group_rule" "ingress_from_openvpn_to_load-generator_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.load-generator_sg.id}"
  description              = "ingress from openvpn to load-generator on 22"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_load-generator_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.load-generator_sg.id}"
  description              = "ingress from mesos-agents to load-generator on 22"
}




resource "aws_security_group_rule" "ingress_self_all_load-generator" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.load-generator_sg.id}"
  description       = "ingress from load-generator to load-generator on all"
}


# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_load-generator" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.load-generator_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_udp_all_load-generator" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.load-generator_sg.id}"
  description       = "engress all on udp ports"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_load-generator" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.load-generator_sg.id}"
  description       = "egress all to vpc cidr"
}
