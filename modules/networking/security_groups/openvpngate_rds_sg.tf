resource "aws_security_group" "openvpngate_rds_sg" {
  tags {
    Name = "${var.env}-${var.region}-openvpngate_rds"
  }

  name        = "${var.env}-${var.region}-openvpngate_rds"
  description = "OpenVPN RDS Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_openvpngate_rds_3306" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.openvpngate_rds_sg.id}"
  description              = "ingress from bastion to openvpngate_rds on port 3306"
}



resource "aws_security_group_rule" "ingress_from_openvpn_3306_to_openvpngate_rds" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.openvpngate_rds_sg.id}"
  description       = "ingress from jenkins to openvpngate_rds on 3306"
}


#Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_openvpngate_rds" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.openvpngate_rds_sg.id}"
  description       = "egress VPC CIDR block"
}
