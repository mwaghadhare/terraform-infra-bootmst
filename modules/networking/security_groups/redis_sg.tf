resource "aws_security_group" "redis_sg" {
  tags {
    Name = "${var.env}-${var.region}-redis"
  }

  name        = "${var.env}-${var.region}-redis"
  description = "Kafka Security Group ${var.env}"
  vpc_id      = "${var.vpc_id}"
}

# Ingress Rules. Better to have them as resources!

resource "aws_security_group_rule" "ingress_from_bastionon_on_6379_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.bastion_sg.id}"
  security_group_id        = "${aws_security_group.redis_sg.id}"
  description              = "ingress from bastion to redis on 6379"
}

resource "aws_security_group_rule" "ingress_self_6379_redis_000" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  self              = true
  security_group_id = "${aws_security_group.redis_sg.id}"
  description       = "ingress from redis to redis on all ports"
}

resource "aws_security_group_rule" "ingress_from_mesos_agents_to_redis_6379" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.mesos-agents_sg.id}"
  security_group_id        = "${aws_security_group.redis_sg.id}"
  description              = "ingress from mesos agents to redis"
}

# Egress Rules. Open Limited ports for outside traffic too.

resource "aws_security_group_rule" "egress_self_6379_redis" {
  type              = "egress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  self              = true
  security_group_id = "${aws_security_group.redis_sg.id}"
  description       = "egress from redis to redis on 6379"
}

resource "aws_security_group_rule" "egress_tcp_all_redis" {
  count             = "${length(var.all_egress_tcp)}"
  type              = "egress"
  from_port         = "${var.all_egress_tcp[count.index]}"
  to_port           = "${var.all_egress_tcp[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.redis_sg.id}"
  description       = "egress all on tcp ports"
}

resource "aws_security_group_rule" "egress_udp_all_redis" {
  count             = "${length(var.all_egress_udp)}"
  type              = "egress"
  from_port         = "${var.all_egress_udp[count.index]}"
  to_port           = "${var.all_egress_udp[count.index]}"
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.redis_sg.id}"
  description       = "egress all on udp ports"
}

resource "aws_security_group_rule" "egress_self_all_redis" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = "${aws_security_group.redis_sg.id}"
  description       = "egress all on tpc ports"
}

resource "aws_security_group_rule" "ingress_from_storm_supervisors_on_6379_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.storm-supervisors_sg.id}"
  security_group_id        = "${aws_security_group.redis_sg.id}"
  description              = "ingress from storm supervisors to redis on 6379"
}

resource "aws_security_group_rule" "ingress_from_predixy_on_6379_to_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.predixy_sg.id}"
  security_group_id        = "${aws_security_group.redis_sg.id}"
  description              = "ingress from predixy to redis on 6379"
}


resource "aws_security_group_rule" "ingress_from_predixy_on_7617_to_redis" {
  type                     = "ingress"
  from_port                = 7617
  to_port                  = 7617
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.predixy_sg.id}"
  security_group_id        = "${aws_security_group.redis_sg.id}"
  description              = "ingress from predixy to redis on 7617"
}