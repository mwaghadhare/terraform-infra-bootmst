resource "aws_security_group" "chef-server_sg" {
  tags {
    Name = "${var.env}-${var.region}-chef-server"
  }

  name        = "${var.env}-${var.region}-chef-server"
  description = "chef-server Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "ingress_port_443_from_all" {
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "ingress to all from 443 port"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_chef-server_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.chef-server_sg.id}"
  description              = "ingress from bastion to chef-server on port 22"
}


resource "aws_security_group_rule" "ingress_port_22_from_openvpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "ingress to port 22 from openvpn"
}


resource "aws_security_group_rule" "egress_tcp_all_chef-server" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "egress all to tcp"
}

resource "aws_security_group_rule" "egress_udp_all_chef-server" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "egress all to udp"
}

resource "aws_security_group_rule" "egress_self_all_chef-server" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "egress from chef-server to chef-server on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_chef-server" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.chef-server_sg.id}"
  description       = "egress all to vpc cidr"
}
