# DB instance
output "rds_db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${aws_db_instance.rds.address}"
}

output "rds_db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = "${aws_db_instance.rds.arn}"
}

output "rds_db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = "${aws_db_instance.rds.availability_zone}"
}

output "rds_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${aws_db_instance.rds.endpoint}"
}

output "rds_db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = "${aws_db_instance.rds.hosted_zone_id}"
}

output "rds_db_instance_id" {
  description = "The RDS instance ID"
  value       = "${aws_db_instance.rds.id}"
}

output "rds_db_instance_resource_id" {
  description = "The RDS Resource ID of rds instance"
  value       = "${aws_db_instance.rds.resource_id}"
}

output "rds_db_instance_status" {
  description = "The RDS instance status"
  value       = "${aws_db_instance.rds.status}"
}

output "rds_db_instance_name" {
  description = "The database name"
  value       = "${aws_db_instance.rds.name}"
}

output "rds_db_instance_username" {
  description = "The master username for the database"
  value       = "${aws_db_instance.rds.username}"
}

output "rds_db_instance_password" {
  description = "The database password (rds password may be old, because Terraform doesn't track it after initial creation)"
  value       = "${var.password}"
}

output "rds_db_instance_port" {
  description = "The database port"
  value       = "${aws_db_instance.rds.port}"
}
