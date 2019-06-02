resource "aws_security_group" "mesos-master_sg" {
  tags {
    Name = "${var.env}-${var.region}-mesos-master"
  }

  name   = "${var.env}-${var.region}-mesos-master"
  vpc_id = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_mesos-master_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from bastion to mesos master on 22"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_mesos-master_5050" {
  type                     = "ingress"
  from_port                = 5050
  to_port                  = 5050
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from bastion to mesos master on 5050"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_mesos-master_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from bastion to mesos master on 8080"
}

resource "aws_security_group_rule" "ingress_from_traefik_papi_to_mesos-master_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from traefik papi to mesos master on 8080"
}


resource "aws_security_group_rule" "ingress_from_jenkins_5050_to_mesos_master" {
  type              = "ingress"
  from_port         = 5050
  to_port           = 5050
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "ingress from jenkins to mesos master on 5050"
}



resource "aws_security_group_rule" "ingress_from_jenkins_8080_to_mesos_master" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "ingress from jenkins to mesos master on 8080"
}

resource "aws_security_group_rule" "ingress_self_all_mesos_master" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "ingress from mesos master to mesos master on all"
}

resource "aws_security_group_rule" "ingress_from_monitor_to_all_mesos_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.monitor_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from monitor to mesos master on all"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_mesos_master" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "egress all tpc ports"
}

resource "aws_security_group_rule" "egress_udp_all_mesos_master" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "engress all on udp ports"
}

resource "aws_security_group_rule" "egress_self_all_mesos_master" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "egress all from mesos master to mesos master"
}

resource "aws_security_group_rule" "egress_all_to_mesos_agents_from_mesos_master" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "egress all to mesos agent from mesos master"
}

resource "aws_security_group_rule" "ingress_all_from_mesos_agents_to_mesos_master" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from mesos agents to mesos masters on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_mesos_master" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.mesos-master_sg.id}"
  description       = "egress all to vpc cidr"
}


resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos_master_5050" {
  type                     = "ingress"
  from_port                = 5050
  to_port                  = 5051
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from openvpn to mesos-master on port 5050 and 5051"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos_master_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from openvpn to mesos-master on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos-master_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-master_sg.id}"
  description              = "ingress from openvpn mesos-master on port 8080"
}
