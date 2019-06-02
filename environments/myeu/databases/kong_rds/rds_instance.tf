module "db_instance" {
  source = "../../../../modules/databases/rds/db_instance/"
  env    = "${var.env}"

  identifier        = "${var.identifier}"
  route53_record    = "${var.route53_record}"
  engine            = "${var.engine}"
  engine_version    = "${var.engine_version}"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_type      = "${var.storage_type}"
  storage_encrypted = "${var.storage_encrypted}"
  kms_key_id        = "${data.terraform_remote_state.kms.kms_key_arn}"
  license_model     = "${var.license_model}"

  name                                = "${var.name}"
  username                            = "${var.username}"
  password                            = "${var.password}"
  port                                = "${var.port}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"

  replicate_source_db = "${var.replicate_source_db}"

  snapshot_identifier = "${var.snapshot_identifier}"

  vpc_security_group_ids = ["${data.terraform_remote_state.vpc.kong_rds_sg_id}"]
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
  zone_id_public         = "${var.zone_id_public}"
  zone_id_private        = "${var.zone_id_private}"

  tags                  = "${var.tags}"
  common_arn            = "${var.common_arn}"
  comparison_operator   = "${var.comparison_operator}"
  evaluation_periods    = "${var.evaluation_periods}"
  metric_name_cpu       = "${var.metric_name_cpu}"
  namespace             = "${var.namespace}"
  period                = "${var.period}"
  statistic             = "${var.statistic}"
  cpu_threshold         = "${var.cpu_threshold}"
  metric_name_dbconn    = "${var.metric_name_dbconn}"
  dbconn_threshold      = "${var.dbconn_threshold}"
  metric_name_dbstorage = "${var.metric_name_dbstorage}"
  dbstorage_threshold   = "${var.database_free_storage_alert_level * 1024 * 1024 * 1024}"
  metric_name_dbmemory  = "${var.metric_name_dbmemory}"
  dbmemory_threshold    = "${var.database_free_memory_alert_level * 1024 * 1024 * 1024}"
}
