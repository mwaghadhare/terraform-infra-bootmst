resource "aws_security_group" "kafka_sg" {
  tags {
    Name = "${var.env}-${var.region}-kafka"
  }

  name        = "${var.env}-${var.region}-kafka"
  description = "Kafka Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!


resource "aws_security_group_rule" "ingress_from_jenkins_6667_to_kafka" {
  type              = "ingress"
  from_port         = 6667
  to_port           = 6667
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "ingress from jenkins to kafka on 6667"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_kafka_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from bastion on 22 to kafka"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from bastion to kafka to 6667"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from mesos master on 6667 to kafka"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from mesos agents on 6667 to kafka"
}

resource "aws_security_group_rule" "ingress_self_all_kafka" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "ingress from kafka on all to kafka"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from openvpn to kafka on port 6667"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_kafka_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from openvpn to kafka on port 22"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_kafka" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "egress all to tcp"
}

resource "aws_security_group_rule" "egress_udp_all_kafka" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "egress all to udp"
}

resource "aws_security_group_rule" "egress_self_all_kafka" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "egress from kafka to kafka on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_kafka" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.kafka_sg.id}"
  description       = "egress all to vpc cidr"
}

resource "aws_security_group_rule" "ingress_from_nimbus_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from nimbus to kafka on port 6667"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from Storm Supervisors to Kafka on port 6667"
}

resource "aws_security_group_rule" "ingress_from_ep-terminators_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from EP Terminators to Kafka on port 6667"
}

resource "aws_security_group_rule" "ingress_from_client-terminators_to_kafka_6667" {
  type                     = "ingress"
  from_port                = 6667
  to_port                  = 6667
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.kafka_sg.id}"
  description              = "ingress from Client Terminators to Kafka on port 6667"
}
