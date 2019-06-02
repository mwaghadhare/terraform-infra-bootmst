module "predixy_nlb" {
  source                        = "../../../../modules/loadbalancers/predixy-nlb/"
  name                          = "${var.name}-nlb"
  region                        = "${var.region}"
  env                           = "${var.env}"
#  alb_security_groups           = ["${data.terraform_remote_state.vpc.predixy_nlb_sg_id}"]
  vpc_id                        = "${data.terraform_remote_state.vpc.vpc_id}"
  subnets                       = ["${data.terraform_remote_state.vpc.public_subnets}"]
  alb_protocols                 = ["TCP"]
#  create_log_bucket             = true
  enable_logging                = true
  log_bucket_name               = "${var.log_bucket_name}"
  log_location_prefix           = "predixy-nlb"
  health_check_path             = "/"
    zone_id_public              = "${var.zone_id_public}"
  zone_id_private               = "${var.zone_id_private}"
  alb_is_internal               = "${var.alb_is_internal}"
  delay                         = "${var.delay}"
#  force_destroy_log_bucket      = "${var.force_destroy_log_bucket}"
  lb_type                       = "${var.lb_type}"
tags {
    "Env"       = "${var.org}-${var.env}-nlb"
  }
}
