resource "aws_security_group" "openvpn_sg" {
  tags {
    Name = "${var.env}-${var.region}-openvpn"
  }

  name        = "${var.env}-${var.region}-openvpn"
  description = "openvpn Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_openvpn_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.openvpn_sg.id}"
  description              = "ingress from bastion to openvpn to 22"
}

resource "aws_security_group_rule" "ingress_self_all_openvpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "ingress from openvpn to openvpn on all ports"
}

resource "aws_security_group_rule" "ingress_from_outside_world_80_openvpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "ingress from outside world to openvpn on 80"
}

resource "aws_security_group_rule" "ingress_from_outside_world_443_tcp_to_openvpn" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "ingress from outside world to openvpn on 443"
}

resource "aws_security_group_rule" "ingress_from_outside_world_1194_udp_to_openvpn" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "ingress from outside world to openvpn on 1194"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_openvpn" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "egress from openvpn on 80,443,2181 to openvpn"
}

resource "aws_security_group_rule" "egress_udp_all_openvpn" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "egress from jenkins  to openvpn on udp "
}

resource "aws_security_group_rule" "egress_self_all_openvpn" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "egress from openvpn to openvpn on all ports"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_openvpn" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "egress all to VPC CIDR from openvpn"
}

resource "aws_security_group_rule" "egress_to_all_from_openvpn" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.openvpn_sg.id}"
  description       = "egress to all from openvpn"
}

#resource "aws_security_group_rule" "ingress_all_to_openvpn_from_cupertino" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["73.92.124.103/32"]
#  security_group_id = "${aws_security_group.openvpn_sg.id}"
#  description       = "ingress all from Cupertino to openvpn"
#}

#resource "aws_security_group_rule" "ingress_all_to_openvpn_from_osman_home" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["24.4.171.214/32"]
#  security_group_id = "${aws_security_group.openvpn_sg.id}"
#  description       = "ingress all from Osman Home to openvpn"
#}
