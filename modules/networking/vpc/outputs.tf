#------------------------------------------------------------------------------------------------------#
#Output from the Module to get in statefile so that we can reference it later                          #
#------------------------------------------------------------------------------------------------------#

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "public_subnets" {
  value = ["${aws_subnet.public.*.id}"]
}

output "private_subnets" {
  value = ["${aws_subnet.private.*.id}"]
}

output "db_subnets" {
  value = ["${aws_subnet.db.*.id}"]
}

output "public_route_table_id" {
  value = "${aws_route_table.public.*.id}"
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}

output "nat_eips" {
  value = ["${aws_eip.nat.*.public_ip}"]
}

output "private_zone_id" {
  value = "${aws_route53_zone.private_zone.*.zone_id}"
}

output "public_zone_id" {
  value = "${aws_route53_zone.public_zone.*.zone_id}"
}

output "flow_log_id" {
  value = "${aws_flow_log.flow_log.*.id}"
}

output "flow_log_cwl_arn" {
  value = "${aws_cloudwatch_log_group.flow_log_group.*.arn}"
}

output "flow_log_cwl_name" {
  value = "${aws_cloudwatch_log_group.flow_log_group.*.name}"
}
