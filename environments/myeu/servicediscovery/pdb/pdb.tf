module "pdb-service-discovery" {
  source              = "../../../../modules/servicediscovery/pdb/"
  instances           = ["${data.terraform_remote_state.pdb.pdb_instance_private_ips}"]
  number_of_instances = "${var.number_of_instances}"
  region              = "${var.region}"
  env                 = "${var.env}"
  bastion_host        = "${data.terraform_remote_state.vpc.bastion_ip}"
  bastion_user        = "${var.user}"
  role_name           = "${var.role_name}"
}
