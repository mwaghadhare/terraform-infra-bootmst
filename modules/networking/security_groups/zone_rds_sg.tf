resource "aws_security_group" "zone_rds_sg" {
  tags {
    Name = "${var.env}-${var.region}-zone_rds"
  }

  name        = "${var.env}-${var.region}-zone_rds"
  description = "TDB RDS Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_zone_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.zone_rds_sg.id}"
  description              = "ingress from bastion to zone_rds on port 5432"
}


resource "aws_security_group_rule" "ingress_from_jenkins_5432_to_zone_rds" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.zone_rds_sg.id}"
  description       = "ingress from jenkins to zone_rds on 5432"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_to_zone_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.zone_rds_sg.id}"
  description              = "ingress from mesos master to zone_rds"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_zone_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.zone_rds_sg.id}"
  description              = "ingress from mesos agents to mesos masters"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_zone_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.zone_rds_sg.id}"
  description              = "ingress from storm supervisors to zone db"
}

#Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_zone_rds" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.zone_rds_sg.id}"
  description       = "egress VPC CIDR block"
}
