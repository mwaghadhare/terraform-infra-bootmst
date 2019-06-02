Mesos Agents  Terraform module
========================

Terraform module which creates AWS Ec2 machines and bootstrap Mesos Agents on AWS SPOT Fleet.

These types of resources are supported:


Usage
-----

```
module "mesos-slave-spot-fleet" {
  source                     = "../../../../modules/services/mesos-agents/"
  key_name                   = "${var.env}-${var.region}"
  security_group             = ["${data.terraform_remote_state.vpc.mesos-agents_sg_id}"]
  org                        = "${var.org}"
  region                     = "${var.region}"
  fullaz                     = "${var.region}a"
  env                        = "${var.env}"
  ami_id                     = "${var.ami_id}"
  subnet_ids                 = "${data.terraform_remote_state.vpc.public_subnets}"
  zone_id_public             = "${var.zone_id_public}"
  zone_id_private            = "${var.zone_id_private}"
  spotprice                  = "${var.spotprice}"
  fleet_role                 = "arn:aws:iam::593333452326:role/aws-ec2-spot-fleet-role"
  targetcapacity             = "${var.targetcapacity}"
  root_volume_type           = "${var.root_volume_type}"
  root_volume_size           = "${var.root_volume_size}"
  root_delete_on_termination = "${var.root_delete_on_termination}"
  validity                   = "${var.validity}"
  terminate_instances        = "${var.terminate_instances}"
}

```
