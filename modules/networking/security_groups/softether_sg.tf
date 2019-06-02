resource "aws_security_group" "softether_sg" {
  tags {
    Name = "${var.env}-${var.region}-softether"
  }

  name        = "${var.env}-${var.region}-softether"
  description = "Softether Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_softether_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.softether_sg.id}"
  description              = "ingress from bastion to softether to 22"
}

resource "aws_security_group_rule" "ingress_self_all_softether" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.softether_sg.id}"
  description       = "ingress from softether to softether on all ports"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_softether" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.softether_sg.id}"
  description       = "egress from softether on 80,443,2181 to softether"
}

resource "aws_security_group_rule" "egress_udp_all_softether" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.softether_sg.id}"
  description       = "egress from jenkins  to softether on udp "
}

resource "aws_security_group_rule" "egress_self_all_softether" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.softether_sg.id}"
  description       = "egress from softether to softether on all ports"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_softether" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.1.0.0/16"]
  security_group_id = "${aws_security_group.softether_sg.id}"
  description       = "egress all to VPC CIDR from softether"
}

#resource "aws_security_group_rule" "ingress_all_to_softether_from_pune" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["114.143.194.102/32"]
#  security_group_id = "${aws_security_group.softether_sg.id}"
#  description       = "ingress all from Pune to softether"
#}

#resource "aws_security_group_rule" "ingress_all_to_softether_from_cupertino" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["73.92.124.103/32"]
#  security_group_id = "${aws_security_group.softether_sg.id}"
#  description       = "ingress all from Cupertino to softether"
#}

#resource "aws_security_group_rule" "ingress_all_to_softether_from_osman_home" {
#  type              = "ingress"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["24.4.171.214/32"]
#  security_group_id = "${aws_security_group.softether_sg.id}"
#  description       = "ingress all from Osman Home to softether"
#}
