module "eu_vpc" {
  source          = "../../../modules/networking/vpc/"
  name            = "eu-vpc"
  env             = "${var.env}"
  domain          = "${var.domain}"
  cidr            = "10.1.0.0/16"
  public_subnets  = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
  db_subnets      = ["10.1.20.0/24", "10.1.21.0/24", "10.1.22.0/24"]
  azs             = "eu-central-1a,eu-central-1b,eu-central-1c"
  region          = "${var.region}"

  #private_domain     = "my.pvt"
  #private_zone_create = true
  zone_id_private = "${var.zone_id_private}"

  nat_gateways_count = 1
  service_name       = "${var.service_name}"
  aws_principal      = "${var.aws_principal}"
}
