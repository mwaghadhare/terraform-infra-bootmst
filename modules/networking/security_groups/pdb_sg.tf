resource "aws_security_group" "pdb_sg" {
  tags {
    Name = "${var.env}-${var.region}-pdb"
  }

  name   = "${var.env}-${var.region}-pdb"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_pdb_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.pdb_sg.id}"
  description              = "ingress from bastion to pdb on 22"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_pdb_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.pdb_sg.id}"
  description              = "ingress from bastion to pdb on 5432"
}


resource "aws_security_group_rule" "ingress_from_jenkins_5432_to_pdb" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "ingress from jenkins to pdb on 5432"
}

resource "aws_security_group_rule" "ingress_from_jenkins_22_to_pdb" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "ingress from jenkins to pdb on 22"
}

resource "aws_security_group_rule" "ingress_self_all_pdb" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "ingress from pdb to pdb on all"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_5432_to_pdb" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.pdb_sg.id}"
  description              = "ingress from mesos agents to pdbs on 5432"
}

resource "aws_security_group_rule" "ingress_from_nimbus_5432_to_pdb" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.pdb_sg.id}"
  description              = "ingress from nimbus to pdbs on 5432"
}

resource "aws_security_group_rule" "ingress_from_strom_supervisors_5432_to_pdb" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.pdb_sg.id}"
  description              = "ingress from storm supervisors to pdbs on 5432"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_pdb" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_udp_all_pdb" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "engress all on udp ports"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_pdb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.pdb_sg.id}"
  description       = "egress all to vpc cidr"
}
