resource "aws_security_group" "zookeeper_sg" {
  tags {
    Name = "${var.env}-${var.region}-zookeeper"
  }

  name        = "${var.env}-${var.region}-zookeeper"
  description = "Zookeeper Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_openvpn_2181_to_zookeeper" {
  type              = "ingress"
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "ingress from VPN on 2181 to zookeeper"
}

resource "aws_security_group_rule" "ingress_from_jenkins_2181_to_zookeeper" {
  type              = "ingress"
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "ingress from jenkins to zookeeper on 2181"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_zookeeper_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from bastion to zookeeper to 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_zookeeper_8090" {
  type                     = "ingress"
  from_port                = 8090
  to_port                  = 8090
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from bastion to zookeeper to 8090"
}

resource "aws_security_group_rule" "ingress_self_all_zookeeper" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "ingress from zookeeper to zookeeper on all ports"
}

resource "aws_security_group_rule" "ingress_from_kafka_2181_zookeeper" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from kafka to zookeeper on 2181"
}

resource "aws_security_group_rule" "ingress_from_nimbus_2181_zookeeper" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from nimbus on 2181 to zookeeper"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_zookeeper" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "egress from zookeeper on 80,443,2181 to zookeeper"
}

resource "aws_security_group_rule" "egress_udp_all_zookeeper" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "egress from jenkins  to zookeeper on udp "
}

resource "aws_security_group_rule" "egress_self_all_zookeeper" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "egress from zookeeper to zookeeper on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_2181_zookeeper" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from mesos master on 2181 to zookeeper"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_2181_zookeeper" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from mesos agents on 2181 to zookeeper"
}

resource "aws_security_group_rule" "ingress_from_storm-supervisors_2181_zookeeper" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from storm supervisors on 2181 to zookeeper"
}

resource "aws_security_group_rule" "ingress_from_ep-terminators_to_zookeeper_2181" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from EP Terminators to zookeeper on port 2181"
}

resource "aws_security_group_rule" "ingress_from_client-terminators_to_zookeeper_2181" {
  type                     = "ingress"
  from_port                = 2181
  to_port                  = 2181
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.zookeeper_sg.id}"
  description              = "ingress from Client Terminators to zookeeper on port 2181"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_zookeeper" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.zookeeper_sg.id}"
  description       = "egress all to VPC CIDR from zookeeper"
}
