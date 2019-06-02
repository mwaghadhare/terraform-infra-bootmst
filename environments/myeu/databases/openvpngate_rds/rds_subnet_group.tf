##################
# DB subnet group
##################
module "db_subnet_group" {
  source = "../../../../modules/databases/rds/db_subnet_group/"

  identifier  = "${var.identifier}"
  name_prefix = "${var.identifier}-"
  subnet_ids  = "${data.terraform_remote_state.vpc.db_subnets}"
  tags        = "${var.tags}"
}
