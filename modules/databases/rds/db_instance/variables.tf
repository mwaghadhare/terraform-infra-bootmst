variable "region" {
  default = ""
}

variable "env" {
  default = ""
}

variable "identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that rds behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set rds to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "replicate_source_db" {
  description = "Specifies that rds resource is a Replicate database, and to use rds value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  default     = ""
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create rds database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = ""
}

variable "license_model" {
  description = "License model information for rds DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  default     = ""
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
}

variable "engine" {
  description = "The database engine to use"
}

variable "engine_version" {
  description = "The engine version to use"
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
}

variable "name" {
  description = "The DB name to create. If omitted, no database is created initially"
}

variable "username" {
  description = "Username for the master DB user"
}

variable "password" {
  description = "Password for the master DB user. Note that rds may show up in logs, and it will be stored in the state file"
}

variable "port" {
  description = "The port on which the DB accepts connections"
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when rds DB instance is deleted."
  default     = false
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting rds implies a storage_type of 'io1'"
  default     = 0
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
  default     = 0
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
  default     = ""
}

variable "monitoring_role_name" {
  description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
  default     = ""
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs."
  default     = true
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing rds parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified)"
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

variable "zone_id_private" {
  description = "The zone_id of the route53 private zone where to create dns records"
}

variable "zone_id_public" {
  description = "The zone_id of the route53 public zone where to create dns records"
}

variable "route53_record" {
  description = "The name of the route53 private hosted  dns records"
}

variable "metric_name_cpu" {
  description = ""
}

variable "metric_name_dbconn" {
  description = ""
}

variable "comparison_operator" {
  description = ""
}

variable "evaluation_periods" {
  description = ""
}

variable "namespace" {
  description = ""
}

variable "period" {
  description = ""
}

variable "statistic" {
  description = ""
}

variable "cpu_threshold" {
  description = ""
}

variable "dbconn_threshold" {
  description = ""
}

variable "common_arn" {
  description = ""
}

variable "metric_name_dbstorage" {
  description = ""
}

variable "dbstorage_threshold" {
  description = ""
}

variable "metric_name_dbmemory" {
  description = ""
}

variable "dbmemory_threshold" {
  description = ""
}
