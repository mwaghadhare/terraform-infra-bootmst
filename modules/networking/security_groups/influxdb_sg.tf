resource "aws_security_group" "influxdb_sg" {
  tags {
    Name = "${var.env}-${var.region}-influxdb"
  }

  name        = "${var.env}-${var.region}-influxdb"
  description = "Influxdb Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_influxdb_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from bastion to influxdb to 22"
}

resource "aws_security_group_rule" "ingress_self_all_influxdb" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.influxdb_sg.id}"
  description       = "ingress from influxdb to influxdb on all ports"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_influxdb" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.influxdb_sg.id}"
  description       = "egress from influxdb on 80,443,2181 to influxdb"
}

resource "aws_security_group_rule" "egress_udp_all_influxdb" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.influxdb_sg.id}"
  description       = "egress from jenkins  to influxdb on udp "
}

resource "aws_security_group_rule" "egress_self_all_influxdb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.influxdb_sg.id}"
  description       = "egress from influxdb to influxdb on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_2003_influxdb" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from mesos master on 2003 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_2003_influxdb" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from zookeeper on 2003 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_cassandra_2003_influxdb" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from cassandra on 2003 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_kafka_2003_influxdb" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from kafka on 2003 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_traefik_2003_influxdb" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from traefik on 2003 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_2004_influxdb" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from mesos master on 2004 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_2004_influxdb" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from zookeeper on 2004 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_cassandra_2004_influxdb" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from cassandra on 2004 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_kafka_2004_influxdb" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from kafka on 2004 to influxdb"
}

resource "aws_security_group_rule" "ingress_from_traefik_2004_influxdb" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.influxdb_sg.id}"
  description              = "ingress from traefik on 2004 to influxdb"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_influxdb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.influxdb_sg.id}"
  description       = "egress all to VPC CIDR from influxdb"
}
