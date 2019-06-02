module "storm-slave-spot-fleet" {
  source                     = "../../../../modules/services/storm-supervisors-ha/"
  key_name                   = "${var.env}-${var.region}"
  security_group             = ["${data.terraform_remote_state.vpc.storm-supervisors_sg_id}"]
  org                        = "${var.org}"
  region                     = "${var.region}"
  fullaz                     = "${var.region}a,${var.region}b,${var.region}c"
  env                        = "${var.env}"
  ami_id                     = "${var.ami_id}"
  subnet_ids                 = "${data.terraform_remote_state.vpc.public_subnets}"
  zone_id_public             = "${var.zone_id_public}"
  zone_id_private            = "${var.zone_id_private}"
  spotprice                  = "${var.spotprice}"
  fleet_role                 = "arn:aws:iam::8888xxxxx:role/aws-ec2-spot-fleet-role"
  targetcapacity_a           = "${var.targetcapacity_a}"
  targetcapacity_b           = "${var.targetcapacity_b}"
  targetcapacity_c           = "${var.targetcapacity_c}"
  root_volume_type           = "${var.root_volume_type}"
  root_volume_size           = "${var.root_volume_size}"
  root_delete_on_termination = "${var.root_delete_on_termination}"
  validity                   = "${var.validity}"
  terminate_instances        = "${var.terminate_instances}"
  strategy                   = "${var.strategy}"
  domain                     = "${var.domain}"
  wc-four                    = "${var.wc-four}"
  wc-eight                   = "${var.wc-eight}"
  wc-sixteen                 = "${var.wc-sixteen}"
  m22xlarge                  = "${var.m22xlarge}"
  m24xlarge                  = "${var.m24xlarge}"
  m3xlarge                   = "${var.m3xlarge}"
  m32xlarge                  = "${var.m32xlarge}"
  m4xlarge                   = "${var.m4xlarge}"
  m42xlarge                  = "${var.m42xlarge}"
  m44xlarge                  = "${var.m44xlarge}"
  m5xlarge                   = "${var.m5xlarge}"
  m52xlarge                  = "${var.m52xlarge}"
  m54xlarge                  = "${var.m54xlarge}"
  c3xlarge                   = "${var.c3xlarge}"
  c32xlarge                  = "${var.c32xlarge}"
  c34xlarge                  = "${var.c34xlarge}"
  c4xlarge                   = "${var.c4xlarge}"
  c42xlarge                  = "${var.c42xlarge}"
  c44xlarge                  = "${var.c44xlarge}"
  c5xlarge                   = "${var.c5xlarge}"
  c52xlarge                  = "${var.c52xlarge}"
  c54xlarge                  = "${var.c54xlarge}"
  i3xlarge                   = "${var.i3xlarge}"
  i32xlarge                  = "${var.i32xlarge}"
  i34xlarge                  = "${var.i34xlarge}"
  r3xlarge                   = "${var.r3xlarge}"
  r32xlarge                  = "${var.r32xlarge}"
  r34xlarge                  = "${var.r34xlarge}"
  r4xlarge                   = "${var.r4xlarge}"
  r42xlarge                  = "${var.r42xlarge}"
  r44xlarge                  = "${var.r44xlarge}"
}
