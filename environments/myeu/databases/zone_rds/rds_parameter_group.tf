#####################
# DB parameter group
#####################
module "db_parameter_group" {
  source = "../../../../modules/databases/rds/db_parameter_group/"

  identifier  = "${var.identifier}"
  name_prefix = "${var.identifier}-"
  family      = "${var.family}"

  parameters = ["${var.parameters}"]

  tags = "${var.tags}"
}
