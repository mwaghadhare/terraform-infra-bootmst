resource "aws_security_group" "praxis_sg" {
  tags {
    Name = "${var.env}-${var.region}-praxis"
  }

  name        = "${var.env}-${var.region}-praxis"
  description = "Bastion Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "egress_tcp_all_praxis" {
  count             = "${length(var.all_egress_praxis_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_praxis_tcp[count.index]}"
  to_port           = "${var.all_egress_praxis_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.praxis_sg.id}"
  description       = "egress to all from praxis sg"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_port_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.praxis_sg.id}"
  description       = "ingress to port 22 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_port_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.praxis_sg.id}"
  description       = "ingress to port 80 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_port_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.praxis_sg.id}"
  description       = "ingress to port 443 from openvpn"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_praxis_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.praxis_sg.id}"
  description              = "ingress from bastion to praxis to 22"
}

