resource "aws_security_group" "traefik_sg" {
  tags {
    Name = "${var.env}-${var.region}-traefik"
  }

  name        = "${var.env}-${var.region}-traefik"
  description = "traefik Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_traefik_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from bastion to traefik on port 22"
}

resource "aws_security_group_rule" "ingress_self_all_traefik" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.traefik_sg.id}"
  description       = "ingress from traefik to traefik on all ports"
}

resource "aws_security_group_rule" "ingress_from_papi_elb_to_traefik_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.papi_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from papi elb to traefik on port 80"
}

resource "aws_security_group_rule" "ingress_from_papi_elb_to_traefik_31016" {
  type                     = "ingress"
  from_port                = 31016
  to_port                  = 31016
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.papi_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from papi elb to traefik on port 31016"
}

resource "aws_security_group_rule" "ingress_from_papi_elb_to_traefik_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.papi_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from papi elb to traefik on port 443"
}

resource "aws_security_group_rule" "ingress_from_service_elb_to_traefik_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.service_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from service elb to traefik on port 80"
}

resource "aws_security_group_rule" "ingress_from_service_elb_to_traefik_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.service_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from service elb to traefik on port 443"
}

resource "aws_security_group_rule" "ingress_from_service_elb_to_traefik_31016" {
  type                     = "ingress"
  from_port                = 31016
  to_port                  = 31016
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.service_elb_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from service elb to traefik on port 31016"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_traefik_31016" {
  type                     = "ingress"
  from_port                = 31016
  to_port                  = 31016
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.traefik_sg.id}"
  description              = "ingress from openvpn to traefik on port 31016"
}

#Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_traefik" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.traefik_sg.id}"
  description       = "egress some ports from traefik sg"
}

resource "aws_security_group_rule" "egress_udp_all_traefik" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.traefik_sg.id}"
  description       = "egress some udp ports from traefik"
}

resource "aws_security_group_rule" "egress_self_all_traefik" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.traefik_sg.id}"
  description       = "egress all from traefik to traefik"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_traefik" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.traefik_sg.id}"
  description       = "egress VPC CIDR block"
}
