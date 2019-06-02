output "ep-terminator_instance_ids" {
  value = "${module.ep-terminator.ep-terminator_instance_ids}"
}

output "ep-terminator_instance_ips" {
  value = "${module.ep-terminator.ep-terminator_instance_ips}"
}

output "ep-terminator_instance_private_ips" {
  value = "${module.ep-terminator.ep-terminator_instance_private_ips}"
}

#output "ep-terminator-key-access_role" {
#  value = "${aws_iam_role.ep-terminator-key-access.arn}"
#}

