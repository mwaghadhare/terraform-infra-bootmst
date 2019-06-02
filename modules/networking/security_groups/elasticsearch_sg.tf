resource "aws_security_group" "elasticsearch_sg" {
  tags {
    Name = "${var.env}-${var.region}-elasticsearch"
  }

  name        = "${var.env}-${var.region}-elasticsearch"
  description = "elasticsearch Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!
resource "aws_security_group_rule" "ingress_self_all_elasticsearch" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "ingress from elasticsearch on all to elasticsearch"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_elasticsearch_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from openvpn to elasticsearch on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_elasticsearch_9200" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from openvpn to elasticsearch on port 9200"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_elasticsearch_5601" {
  type                     = "ingress"
  from_port                = 5601
  to_port                  = 5601
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from openvpn to elasticsearch on port 5601"
}



resource "aws_security_group_rule" "ingress_from_jenkins_22_to_elasticsearch" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.jenkins_sg.id}"
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "ingress from jenkins to elasticsearch on 22"
}

resource "aws_security_group_rule" "ingress_from_bastion_to_elasticsearch_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from bastion on 22 to elasticsearch"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_elasticsearch_9200" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from Storm Supervisors to elasticsearch on port 9200"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_elasticsearch_9300" {
  type                     = "ingress"
  from_port                = 9300
  to_port                  = 9300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from Storm Supervisors to elasticsearch on port 9300"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_elasticsearch_9200" {
  type                     = "ingress"
  from_port                = 9200
  to_port                  = 9200
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from mesos agents on 9200 to elasticsearch"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_elasticsearch_9300" {
  type                     = "ingress"
  from_port                = 9300
  to_port                  = 9300
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.elasticsearch_sg.id}"
  description              = "ingress from mesos agents on 9300 to elasticsearch"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_tcp_all_elasticsearch" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "egress all to tcp"
}

resource "aws_security_group_rule" "egress_udp_all_elasticsearch" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "egress all to udp"
}

resource "aws_security_group_rule" "egress_self_all_elasticsearch" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "egress from elasticsearch to elasticsearch on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_elasticsearch" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.elasticsearch_sg.id}"
  description       = "egress all to vpc cidr"
}
