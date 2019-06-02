# DB parameter group
output "rds_db_parameter_group_id" {
  description = "The db parameter group id"
  value       = "${element(split(",", join(",", aws_db_parameter_group.rds.*.id)), 0)}"
}

output "rds_db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = "${element(split(",", join(",", aws_db_parameter_group.rds.*.arn)), 0)}"
}
