resource "aws_security_group" "ap-qa_sg" {
  tags {
    Name = "${var.env}-${var.region}-ap-qa"
  }

  name        = "${var.env}-${var.region}-ap-qa"
  description = "Bastion Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "egress_tcp_all_ap-qa" {
  count             = "${length(var.all_egress_ap-qa_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_ap-qa_tcp[count.index]}"
  to_port           = "${var.all_egress_ap-qa_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ap-qa_sg.id}"
  description       = "egress to all from ap-qa sg"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_ap-qa_port_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.ap-qa_sg.id}"
  description       = "ingress to port 22 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_ap-qa_port_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.ap-qa_sg.id}"
  description       = "ingress to port 80 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_ap-qa_port_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.ap-qa_sg.id}"
  description       = "ingress to port 443 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_ap-qa_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.ap-qa_sg.id}"
  description              = "ingress from bastion to ap-qa to 22"
}

