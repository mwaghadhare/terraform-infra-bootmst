resource "aws_security_group" "storm-supervisors_sg" {
  tags {
    Name = "${var.env}-${var.region}-storm_supervisors"
  }

  name        = "${var.env}-${var.region}-storm_supervisors"
  description = "Storm Supervisors Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_storm_supervisors_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.storm-supervisors_sg.id}"
  description              = "ingress from bastion to storm supervisors on 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_storm_supervisors_8000" {
  type                     = "ingress"
  from_port                = 8000
  to_port                  = 8000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.storm-supervisors_sg.id}"
  description              = "ingress from openvpn to storm supervisors on 8000"
}

resource "aws_security_group_rule" "ingress_self_all_storm_supervisors" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  description       = "ingress from storm supervisors to stoem supervisors on all"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_self_all_storm_supervisors" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  description       = "egress to self"
}

resource "aws_security_group_rule" "egress_tcp_all_storm_supervisors" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  description       = "egress all tcp"
}

resource "aws_security_group_rule" "egress_udp_all_storm_supervisors" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  description       = "egress all udp"
}

resource "aws_security_group_rule" "egress_all_to_nimbus_from_storm_supervisors" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.storm-supervisors_sg.id}"
  description              = "egress all to nimbus from storm supervisors"
}

resource "aws_security_group_rule" "ingress_all_from_nimbus_to_storm_supervisors" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.storm-supervisors_sg.id}"
  description              = "ingress from nimbus to storm supervisors"
}

resource "aws_security_group_rule" "egress_all_to_zookeeper_from_storm_supervisors" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.storm-supervisors_sg.id}"
  description              = "egress all to zookeeper from storm supervisors"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_storm_supervisors" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  description       = "egress all to vpc cidr"
}
