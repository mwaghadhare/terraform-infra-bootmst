resource "aws_security_group" "consul_sg" {
  tags {
    Name = "${var.env}-${var.region}-consul"
  }

  name   = "${var.env}-${var.region}-consul"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_consul_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from bastion to consul on 22"
}



resource "aws_security_group_rule" "ingress_from_jenkins_8500_to_consul" {
  type              = "ingress"
  from_port         = 8500
  to_port           = 8500
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "ingress from jenkins to consul on 8500"
}

resource "aws_security_group_rule" "ingress_self_all_consul" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "ingress from consul to consul on all"
}

resource "aws_security_group_rule" "ingress_from_monitor_to_all_consul" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.monitor_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from monitor to consul on all"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_consul" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_udp_all_consul" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "engress all on udp ports"
}

resource "aws_security_group_rule" "egress_self_all_consul" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "egress all from consul to consul"
}

resource "aws_security_group_rule" "egress_all_to_mesos_agents_from_consul" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "egress all to mesos agent from consul"
}

resource "aws_security_group_rule" "ingress_all_from_mesos_agents_to_consul" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from mesos agents to consul on all"
}

resource "aws_security_group_rule" "egress_all_to_mesos_master_from_consul" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "egress all to mesos master from consul"
}

resource "aws_security_group_rule" "ingress_all_from_mesos_master_to_consul" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from mesos master to consul on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_consul" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "egress all to vpc cidr"
}

resource "aws_security_group_rule" "ingress_from_kafka_8500_to_consul" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from kafka to consul on 8500"
}

resource "aws_security_group_rule" "ingress_from_kafka_8300_to_consul" {
  type                     = "ingress"
  from_port                = 8300
  to_port                  = 8300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from kafka to consul on 8300"
}

resource "aws_security_group_rule" "ingress_from_kafka_8301_8302_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from kafka to consul on 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_kafka_8301_8302_udp_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from kafka to consul on UDP 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_kafka_8400_to_consul" {
  type                     = "ingress"
  from_port                = 8400
  to_port                  = 8400
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.kafka_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from kafka to consul on 8400"
}

resource "aws_security_group_rule" "ingress_from_cassandra_8500_to_consul" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from cassandra to consul on 8500"
}

resource "aws_security_group_rule" "ingress_from_cassandra_8300_to_consul" {
  type                     = "ingress"
  from_port                = 8300
  to_port                  = 8300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from cassandra to consul on 8300"
}

resource "aws_security_group_rule" "ingress_from_cassandra_8301_8302_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from cassandra to consul on 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_cassandra_8301_8302_udp_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from cassandra to consul on UDP 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_cassandra_8400_to_consul" {
  type                     = "ingress"
  from_port                = 8400
  to_port                  = 8400
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.cassandra_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from cassandra to consul on 8400"
}


resource "aws_security_group_rule" "ingress_from_zookeeper_8500_to_consul" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from zookeeper to consul on 8500"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_8300_to_consul" {
  type                     = "ingress"
  from_port                = 8300
  to_port                  = 8300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from zookeeper to consul on 8300"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_8301_8302_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from zookeeper to consul on 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_8301_8302_udp_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from zookeeper to consul on UDP 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_zookeeper_8400_to_consul" {
  type                     = "ingress"
  from_port                = 8400
  to_port                  = 8400
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.zookeeper_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from zookeeper to consul on 8400"
}

resource "aws_security_group_rule" "ingress_from_pdb_8500_to_consul" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from pdb to consul on 8500"
}

resource "aws_security_group_rule" "ingress_from_pdb_8300_to_consul" {
  type                     = "ingress"
  from_port                = 8300
  to_port                  = 8300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from pdb to consul on 8300"
}

resource "aws_security_group_rule" "ingress_from_pdb_8301_8302_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from pdb to consul on 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_pdb_8301_8302_udp_to_consul" {
  type                     = "ingress"
  from_port                = 8301
  to_port                  = 8302
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from pdb to consul on UDP 8301 and 8302"
}

resource "aws_security_group_rule" "ingress_from_pdb_8400_to_consul" {
  type                     = "ingress"
  from_port                = 8400
  to_port                  = 8400
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.pdb_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from pdb to consul on 8400"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_consul_8500" {
  type                     = "ingress"
  from_port                = 8500
  to_port                  = 8500
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from openvpn to consul on port 5050 and 5051"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_consul_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from openvpn to consul on port 22"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_8500_to_consul" {
  type              = "ingress"
  from_port         = 8500
  to_port           = 8500
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id = "${aws_security_group.consul_sg.id}"
  description       = "ingress from storm supervisors to consul on 8500"
}

resource "aws_security_group_rule" "egress_all_to_storm_supervisors_from_consul" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "egress all to storm supervisors from consul"
}

resource "aws_security_group_rule" "ingress_all_from_storm-supervisors_to_consul" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from storm supervisors to consul on all"
}

resource "aws_security_group_rule" "egress_all_to_nimbus_from_consul" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "egress all to nimbus from consul"
}

resource "aws_security_group_rule" "ingress_all_from_nimbus_to_consul" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.consul_sg.id}"
  description              = "ingress from nimbus to consul on all"
}
