resource "aws_security_group" "mesos-agents_sg" {
  tags {
    Name = "${var.env}-${var.region}-mesos-agents"
  }

  name        = "${var.env}-${var.region}-mesos-agents"
  description = "Kafka Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastion_to_mesos_agents_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from bastion on 22 to mesos agents"
}

resource "aws_security_group_rule" "ingress_self_all_mesos_agents" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  description       = "ingress from mesos agents to mesos agents on all"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_self_all_mesos_agents" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  description       = "egress from mesos agents to mesos agents on all"
}

resource "aws_security_group_rule" "egress_tcp_all_mesos-agents" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  description       = "egress all on tpc"
}

resource "aws_security_group_rule" "egress_udp_all_mesos-agents" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  description       = "egress all on udp"
}

resource "aws_security_group_rule" "egress_all_to_mesos_master_from_mesos_agents" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "egress from mesos agents to mesos master on all"
}

resource "aws_security_group_rule" "ingress_4000_11000_from_traefik_papi_to_mesos_agents" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from traefik to mesos agents on 4000-11000"
}

resource "aws_security_group_rule" "ingress_21000_32000_from_traefik_papi_to_mesos_agents" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.traefik_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from traefik to mesos agents on 22000-32000"
}

resource "aws_security_group_rule" "ingress_all_from_mesos_master_to_mesos_agents" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${aws_security_group.mesos-master_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from mesos master to mesos agents on all"
}

resource "aws_security_group_rule" "egress_all_to_vpc_cidr_from_mesos_agents" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = "${var.cidr}"
  security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  description       = "egress to vpc cider"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos_agents_22" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from openvpn to mesos-agents on port 22"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos_agents_4000_11000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from openvpn to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_openvpn_to_mesos_agents_21000_32000" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from openvpn to mesos-agents on port 21000 to 32000"
}

resource "aws_security_group_rule" "ingress_from_nimbus_to_mesos_agents_4000_11000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from nimbus to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_mesos_agents_4000_11000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from storm_supervisors to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_nimbus_to_mesos_agents_21000_32000" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.nimbus_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from Nimbus to mesos-agents on port 21000 to 32000"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_to_mesos_agents_21000_32000" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from Storm Supervisors to mesos-agents on port 21000 to 32000"
}

resource "aws_security_group_rule" "egress_from_mesos_agents_to_open_vpn_1194_udp" {
  type                     = "egress"
  from_port                = 1194
  to_port                  = 1194
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "egress from mesos-agents to openvpn on port 1194 udp"
}

resource "aws_security_group_rule" "egress_from_mesos_agents_to_open_vpn_1194_tcp" {
  type                     = "egress"
  from_port                = 1194
  to_port                  = 1194
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.openvpn_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "egress from mesos-agents to openvpn on port 1194 tcp"
}

# This is required for iptun to work - which means any service that uses iptun
# and runs in mesos
#   ntp
#   dizzy
#   wlc
# and anything else in future
resource "aws_security_group_rule" "ingress_from_epterm_to_mesos_agents_4000_11000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_epterm_to_mesos_agents_21000_32000" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 21000 to 32000"
}


resource "aws_security_group_rule" "ingress_from_client_term_to_mesos_agents_4000_11000" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_client_term_to_mesos_agents_21000_32000" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from client-terminator to mesos-agents on port 21000 to 32000"
}

resource "aws_security_group_rule" "ingress_from_epterm_to_mesos_agents_4000_11000_udp" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_epterm_to_mesos_agents_21000_32000_udp" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.ep-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 21000 to 32000"
}


resource "aws_security_group_rule" "ingress_from_client_term_to_mesos_agents_4000_11000_udp" {
  type                     = "ingress"
  from_port                = 4000
  to_port                  = 11000
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from ep-terminator to mesos-agents on port 4000 to 11000"
}

resource "aws_security_group_rule" "ingress_from_client_term_to_mesos_agents_21000_32000_udp" {
  type                     = "ingress"
  from_port                = 21000
  to_port                  = 32000
  protocol                 = "udp"
  source_security_group_id = "${aws_security_group.client-terminator_sg.id}"
  security_group_id        = "${aws_security_group.mesos-agents_sg.id}"
  description              = "ingress from client-terminator to mesos-agents on port 21000 to 32000"
}
