resource "aws_security_group" "jenkins_sg" {
  tags {
    Name = "${var.env}-${var.region}-jenkins"
  }

  name        = "${var.env}-${var.region}-jenkins"
  description = "Nimbus Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_jenkins_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.jenkins_sg.id}"
  description              = "ingress from bastion to jenkins on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_jenkins_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.jenkins_sg.id}"
  description              = "ingress from openvpn to jenkins on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_jenkins_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.jenkins_sg.id}"
  description              = "ingress from openvpn to jenkins on port 8080"
}

resource "aws_security_group_rule" "ingress_self_all_jenkins" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "ingress from jenkins to jenkins on all"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_self_all_jenkins" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_udp_all_jenkins" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "egress all on udp ports"
}

resource "aws_security_group_rule" "egress_tcp_all_jenkins" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "egress all on tcp ports"
}

resource "aws_security_group_rule" "egress_all_jenkins" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "egress all from jenkins"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_jenkins" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.jenkins_sg.id}"
  description       = "egress all to vpc cidr"
}
