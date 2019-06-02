resource "aws_security_group" "predixy_sg" {
  tags {
    Name = "${var.env}-${var.region}-predixy"
  }

  name        = "${var.env}-${var.region}-predixy"
  description = "Predixy Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_openvpn_on_22_to_predixy" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.predixy_sg.id}"
  description              = "ingress from openvpn to predixy on 22"
}

resource "aws_security_group_rule" "ingress_from_bastion_on_22_to_predixy" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.predixy_sg.id}"
  description              = "ingress from bastion to predixy on 22"
}

resource "aws_security_group_rule" "ingress_from_bastion_on_7617_to_predixy" {
  type                     = "ingress"
  from_port                = 7617
  to_port                  = 7617
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.predixy_sg.id}"
  description              = "ingress from bastion to predixy on 7617"
}

 resource "aws_security_group_rule" "ingress_self_6379_predixy" {
   type              = "ingress"
   from_port         = 6379
   to_port           = 6379
   protocol          = "tcp"
   self              = true
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "ingress from redis to predixy on all ports"
 }

 resource "aws_security_group_rule" "ingress_self_7617_predixy" {
   type              = "ingress"
   from_port         = 7617
   to_port           = 7617
   protocol          = "tcp"
   self              = true
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "ingress from redis to predixy on all ports"
 }


 resource "aws_security_group_rule" "egress_self_6379_predixy" {
   type              = "egress"
   from_port         = 6379
   to_port           = 6379
   protocol          = "tcp"
   self              = true
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "egress from redis proxy to predixy on 6379"
 }

 resource "aws_security_group_rule" "egress_self_7617_predixy" {
   type              = "egress"
   from_port         = 7617
   to_port           = 7617
   protocol          = "tcp"
   self              = true
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "egress from redis proxy to predixy on 7617"
 }

 resource "aws_security_group_rule" "egress_tcp_all_predixy" {
   count             = "${length(var.all_egress_tcp)}"
   type              = "egress"
   from_port         = "${var.all_egress_tcp[count.index]}"
   to_port           = "${var.all_egress_tcp[count.index]}"
   protocol          = "tcp"
   cidr_blocks       = ["0.0.0.0/0"]
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "egress all on tcp ports"
 }

 resource "aws_security_group_rule" "egress_udp_all_predixy" {
   count             = "${length(var.all_egress_udp)}"
   type              = "egress"
   from_port         = "${var.all_egress_udp[count.index]}"
   to_port           = "${var.all_egress_udp[count.index]}"
   protocol          = "udp"
   cidr_blocks       = ["0.0.0.0/0"]
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "egress all on udp ports"
 }

 resource "aws_security_group_rule" "egress_self_all_predixy" {
   type              = "egress"
   from_port         = 0
   to_port           = 0
   protocol          = "-1"
   self              = true
   security_group_id = "${aws_security_group.predixy_sg.id}"
   description       = "egress all on tpc ports"
 }

 resource "aws_security_group_rule" "ingress_from_openvpn_on_6379_to_predixy" {
   type                     = "ingress"
   from_port                = 6379
   to_port                  = 6379
   protocol                 = "tcp"
   source_security_group_id = "${aws_security_group.openvpn_sg.id}"
   security_group_id        = "${aws_security_group.predixy_sg.id}"
   description              = "ingress from openvpn to predixy on 6379"
 }

 resource "aws_security_group_rule" "ingress_from_openvpn_on_7617_to_predixy" {
   type                     = "ingress"
   from_port                = 7617
   to_port                  = 7617
   protocol                 = "tcp"
   source_security_group_id = "${aws_security_group.openvpn_sg.id}"
   security_group_id        = "${aws_security_group.predixy_sg.id}"
   description              = "ingress from openvpn to predixy on 7617"
 }


resource "aws_security_group_rule" "egress_tcp_all_predixy_out" {
  count             = "${length(var.all_egress_predixy_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_predixy_tcp[count.index]}"
  to_port           = "${var.all_egress_predixy_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.predixy_sg.id}"
  description       = "egress to all from predixy sg"
}