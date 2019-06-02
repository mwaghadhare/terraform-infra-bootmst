resource "aws_security_group" "papi_rds_sg" {
  tags {
    Name = "${var.env}-${var.region}-papi_rds"
  }

  name        = "${var.env}-${var.region}-papi_rds"
  description = "Papi RDS Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_papi_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.papi_rds_sg.id}"
  description              = "ingress from bastion to papi_rds on port 5432"
}



resource "aws_security_group_rule" "ingress_from_jenkins_5432_to_papi_rds" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.papi_rds_sg.id}"
  description       = "ingress from jenkins to papi_rds on 5432"
}

resource "aws_security_group_rule" "ingress_from_mesos_master_to_papi_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.papi_rds_sg.id}"
  description              = "ingress from mesos master to papi_rds"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_papi_rds_5432" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.papi_rds_sg.id}"
  description              = "ingress from mesos agents to papi_rds"
}

#Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_papi_rds" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.papi_rds_sg.id}"
  description       = "egress VPC CIDR block"
}
