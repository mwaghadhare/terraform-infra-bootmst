resource "aws_security_group" "nimbus_sg" {
  tags {
    Name = "${var.env}-${var.region}-nimbus"
  }

  name        = "${var.env}-${var.region}-nimbus"
  description = "Nimbus Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_nimbus_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from bastion to nimbus on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_nimbus_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from openvpn to nimbus on port 8080"
}

resource "aws_security_group_rule" "ingress_from_jenkins_to_nimbus_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from jenkins to nimbus on port 8080"
}

resource "aws_security_group_rule" "ingress_from_jenkins_to_nimbus_6627" {
  type                     = "ingress"
  from_port                = 6627
  to_port                  = 6627
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from jenkins to nimbus on port 6627"
}

resource "aws_security_group_rule" "ingress_self_all_nimbus" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.nimbus_sg.id}"
  description       = "ingress from nimbus to nimbus on all"
}

resource "aws_security_group_rule" "ingres_all_storm_supervisors" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from storm supervisors to nimbus"
}

resource "aws_security_group_rule" "ingres_from_mesos_agents_to_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from mesos agents to nimbus on port 8080"
}

resource "aws_security_group_rule" "ingres_from_praxis_to_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.praxis_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from praxis to nimbus on port 8080"
}

resource "aws_security_group_rule" "ingres_from_openvpn_to_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.nimbus_sg.id}"
  description              = "ingress from openvpn to nimbus on port 8080"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_self_all_nimbus" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.nimbus_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_tcp_all_nimbus" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nimbus_sg.id}"
  description       = "egress all on tcp ports"
}

resource "aws_security_group_rule" "egress_udp_all_nimbus" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.nimbus_sg.id}"
  description       = "egress all on udp ports"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_nimbus" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.nimbus_sg.id}"
  description       = "egress all to vpc cidr"
}
