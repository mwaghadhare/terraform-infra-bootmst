resource "aws_cloudwatch_log_group" "notifier" {
  name              = "/my/${var.env}/notifier"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "notifier" {
  name           = "notifier"
  log_group_name = "${aws_cloudwatch_log_group.notifier.name}"
}
