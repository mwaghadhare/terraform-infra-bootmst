Nimbus Terraform module
========================

Terraform module which creates AWS Ec2 machines and install Apache Nimbus.

These types of resources are supported:


Usage
-----

```
module "nimbus" {
  source                     = "../../../../modules/services/nimbus/"
  key_name                   = "${var.env}-${var.region}"
  security_groups            = ["${data.terraform_remote_state.vpc.nimbus_sg_id}"]
  org                        = "mysys"
  region                     = "${var.region}"
  fullaz                     = "${var.region}b"
  env                        = "${var.env}"
  instance_type              = "${var.instance_type}"
  name                       = "nimbus"
  subnet_ids                 = "${data.terraform_remote_state.vpc.public_subnets}"
  org_validator              = "mysys-inc-validator"
  number_of_instances        = "1"
  bastion_host               = "${data.terraform_remote_state.vpc.bastion_ip}"
  bastion_user               = "ubuntu"
  zone_id_public             = "${var.zone_id_public}"
  zone_id_private            = "${var.zone_id_private}"
  root_volume_type           = "${var.root_volume_type}"
  root_volume_size           = "${var.root_volume_size}"
  root_delete_on_termination = "${var.root_delete_on_termination}"
  opt_device_name            = "${var.opt_device_name}"
  opt_volume_type            = "${var.opt_volume_type}"
  opt_volume_size            = "${var.opt_volume_size}"
  opt_delete_on_termination  = "${var.opt_delete_on_termination}"
  data_device_name           = "${var.data_device_name}"
  data_volume_type           = "${var.data_volume_type}"
  data_volume_size           = "${var.data_volume_size}"
  data_delete_on_termination = "${var.data_delete_on_termination}"
}
```
