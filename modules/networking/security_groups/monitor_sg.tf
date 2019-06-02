resource "aws_security_group" "monitor_sg" {
  tags {
    Name = "${var.env}-${var.region}-monitor"
  }

  name        = "${var.env}-${var.region}-monitor"
  description = "Monitor Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_monitor_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from bastion to monitor to 22"
}

resource "aws_security_group_rule" "ingress_self_all_monitor" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.monitor_sg.id}"
  description       = "ingress from monitor to monitor on all ports"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_monitor" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.monitor_sg.id}"
  description       = "egress from monitor on 80,443,2181 to monitor"
}

resource "aws_security_group_rule" "egress_udp_all_monitor" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.monitor_sg.id}"
  description       = "egress from jenkins  to monitor on udp "
}

resource "aws_security_group_rule" "egress_self_all_monitor" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.monitor_sg.id}"
  description       = "egress from monitor to monitor on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_5555_monitor" {
  type                     = "ingress"
  from_port                = 5555
  to_port                  = 5555
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from mesos master on 5555 to monitor"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_5555_monitor" {
  type                     = "ingress"
  from_port                = 5555
  to_port                  = 5555
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from mesos agents on 5555 to monitor"
}

resource "aws_security_group_rule" "ingress_from_ep_terminator_5555_monitor" {
  type                     = "ingress"
  from_port                = 5555
  to_port                  = 5555
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from ep-terminator on 5555 to monitor"
}

resource "aws_security_group_rule" "ingress_from_client_terminator_5555_monitor" {
  type                     = "ingress"
  from_port                = 5555
  to_port                  = 5555
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from client-terminator on 5555 to monitor"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_5556_monitor" {
  type                     = "ingress"
  from_port                = 5556
  to_port                  = 5556
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from mesos master on 5556 to monitor"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_5556_monitor" {
  type                     = "ingress"
  from_port                = 5556
  to_port                  = 5556
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from mesos agents on 5556 to monitor"
}

resource "aws_security_group_rule" "ingress_from_ep_terminator_5556_monitor" {
  type                     = "ingress"
  from_port                = 5556
  to_port                  = 5556
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from ep-terminator on 5556 to monitor"
}

resource "aws_security_group_rule" "ingress_from_client_terminator_5556_monitor" {
  type                     = "ingress"
  from_port                = 5556
  to_port                  = 5556
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from client-terminator on 5556 to monitor"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_monitor" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.monitor_sg.id}"
  description       = "egress all to VPC CIDR from monitor"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_monitor_3000" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from openvpn to monitor on port 3000"
}

resource "aws_security_group_rule" "ingress_from_jenkins_to_monitor_3000" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from Jenkins to monitor on port 3000"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_monitor_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from openvpn to monitor on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_monitor_4567" {
  type                     = "ingress"
  from_port                = 4567
  to_port                  = 4567
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.monitor_sg.id}"
  description              = "ingress from openvpn to monitor on port 4567"
}
