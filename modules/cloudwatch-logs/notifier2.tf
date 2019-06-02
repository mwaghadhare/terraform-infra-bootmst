resource "aws_cloudwatch_log_group" "notifier2" {
  name              = "/my/${var.env}/notifier2"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "notifier2" {
  name           = "notifier2"
  log_group_name = "${aws_cloudwatch_log_group.notifier2.name}"
}
