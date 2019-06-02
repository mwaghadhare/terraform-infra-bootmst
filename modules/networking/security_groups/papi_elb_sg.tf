resource "aws_security_group" "papi_elb_sg" {
  tags {
    Name = "${var.env}-${var.region}-papi_elb"
  }

  name   = "${var.env}-${var.region}-papi_elb"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_openvpn_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from openvpn to papi elb to 80"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_papi_elb_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from openvpn to papi elb to 22"
}

resource "aws_security_group_rule" "ingress_from_ep_terminator_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from ep-terminator to papi_elb on 80"
}

resource "aws_security_group_rule" "ingress_from_client_terminator_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from client-terminator to papi_elb on 80"
}

resource "aws_security_group_rule" "ingress_from_kong_to_papi_elb_on_all_tcp_traffic" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kong_sg.id}"
  description       = "ingress from kong to papi_elb on all tcp traffic"
}

##Egres

resource "aws_security_group_rule" "egress_tcp_all_papi_elb" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.papi_elb_sg.id}"
  description       = "egress some ports from papi_elb sg"
}

resource "aws_security_group_rule" "egress_udp_all_papi_elb" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.papi_elb_sg.id}"
  description       = "egress some udp ports from papi_elb"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_papi_elb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.1.0.0/16"]
  security_group_id = "${aws_security_group.papi_elb_sg.id}"
  description       = "egress VPC CIDR block"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from storm supervisors to papi elb to 80"
}

resource "aws_security_group_rule" "ingress_from_nimbus_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from nimbus to papi elb to 80"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from mesos-agents to papi elb to 80"
}

resource "aws_security_group_rule" "ingress_from_kong_to_papi_elb_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kong_sg.id}"
  security_group_id        = "${aws_security_group.papi_elb_sg.id}"
  description              = "ingress from kong to papi elb to 80"
}
