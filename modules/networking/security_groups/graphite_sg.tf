resource "aws_security_group" "graphite_sg" {
  tags {
    Name = "${var.env}-${var.region}-graphite"
  }

  name        = "${var.env}-${var.region}-graphite"
  description = "Graphite Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_graphite_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from bastion to graphite to 22"
}

resource "aws_security_group_rule" "ingress_from_monitor_to_graphite_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.monitor_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
}

resource "aws_security_group_rule" "ingress_from_kong_to_graphite_8080" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kong_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
}

resource "aws_security_group_rule" "ingress_from_client-terminator_to_graphite_8080" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
}

resource "aws_security_group_rule" "ingress_from_ep-terminator_to_graphite_8080" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
}


resource "aws_security_group_rule" "ingress_self_all_graphite" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.graphite_sg.id}"
  description       = "ingress from graphite to graphite on all ports"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_graphite" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.graphite_sg.id}"
  description       = "egress from graphite on 80,443,2181 to graphite"
}

resource "aws_security_group_rule" "egress_udp_all_graphite" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.graphite_sg.id}"
  description       = "egress from jenkins  to graphite on udp "
}

resource "aws_security_group_rule" "egress_self_all_graphite" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.graphite_sg.id}"
  description       = "egress from graphite to graphite on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from mesos master on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_nimbus_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from nimbus on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_elasticsearch_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from elasticsearch on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_pdb_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from pdb on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_mesosagents_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from mesos agents on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from zookeeper on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_cassandra_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from cassandra on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_kafka_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from kafka on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_traefik_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from traefik on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_monitor_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.monitor_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from monitor on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_2003_graphite" {
  type                     = "ingress"
  from_port                = 2003
  to_port                  = 2003
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from storm supervisors on 2003 to graphite"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from mesos master on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_elasticsearch_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from elasticsearch on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_pdb_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from pdb on 2004 to graphite"
}


resource "aws_security_group_rule" "ingress_from_nimbus_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from nimbus on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from mesos agents on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from zookeeper on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_cassandra_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from cassandra on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_kafka_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from kafka on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_traefik_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from traefik on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_monitor_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.monitor_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from monitor on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_2004_graphite" {
  type                     = "ingress"
  from_port                = 2004
  to_port                  = 2004
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from storm supervisors on 2004 to graphite"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_graphite_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from openvpn to graphite on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_graphite_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.graphite_sg.id}"
  description              = "ingress from openvpn to graphite on port 22"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_graphite" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.graphite_sg.id}"
  description       = "egress all to VPC CIDR from graphite"
}
