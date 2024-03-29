module "nimbus-ha" {
  source                     = "../../../../modules/services/nimbus-ha/"
  key_name                   = "${var.env}-${var.region}"
  security_groups            = ["${data.terraform_remote_state.vpc.nimbus_sg_id}"]
  org                        = "${var.org}"
  region                     = "${var.region}"
  fullaz                     = "${var.region}b"
  env                        = "${var.env}"
  instance_type              = "${var.instance_type}"
  name                       = "${var.name}"
  subnet_ids                 = "${data.terraform_remote_state.vpc.public_subnets}"
  org_validator              = "${var.org}-eu-validator"
  number_of_instances        = "${var.number_of_instances}"
  bastion_host               = "${data.terraform_remote_state.vpc.bastion_ip}"
  bastion_user               = "${var.user}"
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
  source_dest_check          = "${var.source_dest_check}"
  monitoring                 = "${var.monitoring}"
  cpu_topic_arn              = "${var.cpu_topic_arn}"
  status_check_arn           = "${var.status_check_arn}"
  comparison_operator        = "${var.comparison_operator}"
  evaluation_periods         = "${var.evaluation_periods}"
  metric_name                = "${var.metric_name}"
  namespace                  = "${var.namespace}"
  period                     = "${var.period}"
  statistic                  = "${var.statistic}"
  threshold                  = "${var.threshold}"
  cpu_metric_name            = "${var.cpu_metric_name}"
  cpu_statistic              = "${var.cpu_statistic}"
  cpu_threshold              = "${var.cpu_threshold}"
  chef_fqdn                  = "${var.chef_fqdn}"
  role_name                  = "${var.role_name}"
}
