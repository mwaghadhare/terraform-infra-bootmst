module "eu_security_groups" {
  source        = "../../../modules/networking/security_groups"
  vpc_id        = "${module.eu_vpc.vpc_id}"
  env           = "${var.env}"
  region        = "${var.region}"
  bastion_sg_id = "${module.eu_security_groups.bastion_sg_id}"
  cidr          = ["10.1.0.0/16"]
}
