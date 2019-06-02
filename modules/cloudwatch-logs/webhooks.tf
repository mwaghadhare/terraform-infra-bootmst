resource "aws_cloudwatch_log_group" "webhooks" {
  name              = "/my/${var.env}/webhooks"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "webhooks" {
  name           = "webhooks"
  log_group_name = "${aws_cloudwatch_log_group.webhooks.name}"
}
