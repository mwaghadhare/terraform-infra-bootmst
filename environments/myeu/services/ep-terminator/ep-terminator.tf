module "ep-terminator" {
  source          = "../../../../modules/services/ep-terminator/"
  key_name        = "${var.env}-${var.region}"
  security_groups = ["${data.terraform_remote_state.vpc.ep-terminator_sg_id}"]

  #  org                        = "${var.org}"
  region                     = "${var.region}"
  fullaz                     = "${var.region}b"
  env                        = "${var.env}"
  instance_type              = "${var.instance_type}"
  name                       = "${var.name}"
  subnet_ids                 = "${data.terraform_remote_state.vpc.public_subnets}"
  org_validator              = "${var.org}-eu-validator"
  number_of_instances        = "${var.number_of_instances}"
  zone_id_public             = "${var.zone_id_public}"
  zone_id_private            = "${var.zone_id_private}"
  root_volume_type           = "${var.root_volume_type}"
  root_volume_size           = "${var.root_volume_size}"
  root_delete_on_termination = "${var.root_delete_on_termination}"
  bastion_host               = "${data.terraform_remote_state.vpc.bastion_ip}"
  bastion_user               = "${var.user}"
  #  data_device_name           = "${var.data_device_name}"
  #  data_volume_type           = "${var.data_volume_type}"
  #  data_volume_size           = "${var.data_volume_size}"
  #  data_delete_on_termination = "${var.data_delete_on_termination}"
  source_dest_check = "${var.source_dest_check}"

  monitoring = "${var.monitoring}"

  #  ami_id                     = "${var.ami_id}"
  aws_account_id       = "${var.aws_account_id}"
  iam_instance_profile = "${coalesce(var.instance_profile,join("",aws_iam_instance_profile.ep-terminator_iam_profile.*.name))}"
  key_access_role      = "${aws_iam_role.ep-terminator-key-access.arn}"
  chef_fqdn                  = "${var.chef_fqdn}"
}