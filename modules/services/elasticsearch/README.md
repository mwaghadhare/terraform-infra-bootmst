elasticsearch Terraform module
========================

Terraform module which creates AWS Ec2 machines and install Apache elasticsearch.

These types of resources are supported:


Usage
-----

```
module "elasticsearch" {
  source              = "../../../../modules/services/elasticsearch/"
  key_name            = "${var.env}-${var.region}"
  security_groups     = ["${data.terraform_remote_state.vpc.elasticsearch_sg_id}"]
  org                 = "mysys"
  region              = "${var.region}"
  fullaz              = "${var.region}b"
  env                 = "${var.env}"
  instance_type       = "${var.instance_type}"
  name                = "elasticsearch"
  subnet_ids          = "${data.terraform_remote_state.vpc.public_subnets}"
  org_validator       = "mysys-inc-validator"
  number_of_instances = "3"
  bastion_host        = "${data.terraform_remote_state.vpc.bastion_ip}"
  bastion_user        = "ubuntu"
  zone_id_public      = "${var.zone_id_public}"
  zone_id_private     = "${var.zone_id_private}"
  disk_size           = "${var.disk_size}"
}
```
