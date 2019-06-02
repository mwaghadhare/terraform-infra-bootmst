resource "aws_security_group" "cassandra_sg" {
  tags {
    Name = "${var.env}-${var.region}-cassandra"
  }

  name        = "${var.env}-${var.region}-cassandra"
  description = "Cassandra Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_cassandra_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from bastion to cassandra on port 22"
}

resource "aws_security_group_rule" "ingress_from_jenkins_9042_to_cassandra" {
  type              = "ingress"
  from_port         = 9042
  to_port           = 9042
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "ingress from jenkins to pdb on 9042"
}

resource "aws_security_group_rule" "ingress_self_all_cassandra" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "ingress from cassandra to cassandra on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_to_cassandra_9042" {
  type                     = "ingress"
  from_port                = 9042
  to_port                  = 9042
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from mesos master to cassandra on port 9042"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_cassandra_9042" {
  type                     = "ingress"
  from_port                = 9042
  to_port                  = 9042
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from mesos agents to cassandra on port 9042"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_cassandra_9042" {
  type                     = "ingress"
  from_port                = 9042
  to_port                  = 9042
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from openvpn to cassandra on port 9042"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_cassandra_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from openvpn to cassandra on port 22"
}

#Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_cassandra" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "egress some ports from cassandra"
}

resource "aws_security_group_rule" "egress_udp_all_cassandra" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "egress some udp ports from cassandra"
}

resource "aws_security_group_rule" "egress_self_all_cassandra" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "egress all from cassandra to cassandra"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_cassandra" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.cassandra_sg.id}"
  description       = "egress VPC CIDR block"
}

resource "aws_security_group_rule" "ingress_from_nimbus_to_cassandra_9042" {
  type                     = "ingress"
  from_port                = 9042
  to_port                  = 9042
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from nimbus to cassandra on port 9042"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_cassandra_9042" {
  type                     = "ingress"
  from_port                = 9042
  to_port                  = 9042
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.cassandra_sg.id}"
  description              = "ingress from Storm Supervisors to cassandra on port 9042"
}
