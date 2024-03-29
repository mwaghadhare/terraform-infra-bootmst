# terraform-aws-postgresql-rds

A Terraform module to create an Amazon Web Services (AWS) PostgreSQL Relational Database Server (RDS) for KONG.

## Usage

```
module "db_instance" {
  source = "../../../../modules/databases/rds/db_instance/"

  identifier = "${var.identifier}"

  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${var.kms_key_id}"
  license_model     = "${var.license_model}"

  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  port                                = "${var.port}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  replicate_source_db = "${var.replicate_source_db}"

  snapshot_identifier = "${var.snapshot_identifier}"

  vpc_security_group_ids = ["${data.terraform_remote_state.vpc.rds_sg_id}"]
  db_subnet_group_name   = "${module.db_subnet_group.rds_db_subnet_group_id}"
  parameter_group_name   = "${module.db_parameter_group.rds_db_parameter_group_id}"

  multi_az            = "${var.multi_az}"
  iops                = "${var.iops}"
  publicly_accessible = "${var.publicly_accessible}"

  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"
  skip_final_snapshot         = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot       = "${var.copy_tags_to_snapshot}"
  final_snapshot_identifier   = "${var.final_snapshot_identifier}"

  backup_retention_period = "${var.backup_retention_period}"
  backup_window           = "${var.backup_window}"

  monitoring_interval    = "${var.monitoring_interval}"
  monitoring_role_arn    = "${var.monitoring_role_arn}"
  monitoring_role_name   = "${var.monitoring_role_name}"
  create_monitoring_role = "${var.create_monitoring_role}"

  tags = "${var.tags}"
```
