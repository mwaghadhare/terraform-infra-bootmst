# DB subnet group
output "rds_db_subnet_group_id" {
  description = "The db subnet group name"
  value       = "${element(concat(aws_db_subnet_group.rds.*.id, list("")), 0)}"
}

output "rds_db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = "${element(concat(aws_db_subnet_group.rds.*.arn, list("")), 0)}"
}
