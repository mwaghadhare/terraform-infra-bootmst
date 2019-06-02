output "alb_dns_name" {
  description = "The DNS name of the ALB presumably to be used with a friendlier CNAME."
  value       = "${aws_alb.predixy_nlb.dns_name}"
}

output "alb_id" {
  description = "The ID of the ALB we created."
  value       = "${aws_alb.predixy_nlb.id}"
}

output "alb_listener_6379_id" {
  description = "The ID of the ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_6379.*.id, list("")), 0)}"
}

output "alb_listener_7617_id" {
  description = "The ID of the ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_7617.*.id, list("")), 0)}"
}

output "alb_listener_6379_arn" {
  description = "The ARN of the TCP ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_6379.*.arn, list("")), 0)}"
}

output "alb_listener_7617_arn" {
  description = "The ARN of the TCP ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_7617.*.arn, list("")), 0)}"
}

output "alb_zone_id" {
  description = "The zone_id of the ALB to assist with creating DNS records."
  value       = "${aws_alb.predixy_nlb.zone_id}"
}

output "target_group_arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value       = "${aws_alb_target_group.target_group.arn}"
}

output "alb_arn" {
  description = "ARN of the ALB itself. Useful for debug output, for example when attaching a WAF."
  value       = "${aws_alb.predixy_nlb.arn}"
}
