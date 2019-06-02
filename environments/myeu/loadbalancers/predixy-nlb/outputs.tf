output "alb_dns_name" {
description = "The DNS name of the ALB presumably to be used with a friendlier CNAME."
  value       = "${module.predixy_nlb.alb_dns_name}"
}

output "alb_id" {
  description = "The ID of the ALB we created."
  value       = "${module.predixy_nlb.alb_id}"
}



output "alb_zone_id" {
  description = "The zone_id of the ALB to assist with creating DNS records."
  value       = "${module.predixy_nlb.alb_zone_id}"
}


output "target_group_arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value       = "${module.predixy_nlb.target_group_arn}"
}

output "alb_arn" {
  description = "ARN of the ALB itself. Useful for debug output, for example when attaching a WAF."
  value       = "${module.predixy_nlb.alb_arn}"
}
