resource "aws_security_group" "bastion_sg" {
  tags {
    Name = "${var.env}-${var.region}-bastion"
  }

  name        = "${var.env}-${var.region}-bastion"
  description = "Bastion Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "egress_tcp_all_bastion" {
  count             = "${length(var.all_egress_bastion_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_bastion_tcp[count.index]}"
  to_port           = "${var.all_egress_bastion_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion_sg.id}"
  description       = "egress to all from bastion sg"
}

resource "aws_security_group_rule" "ingress_port_22_from_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.bastion_sg.id}"
  description       = "ingress to port 22 from openvpn"
}
