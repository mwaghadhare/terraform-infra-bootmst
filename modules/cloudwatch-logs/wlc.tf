resource "aws_cloudwatch_log_group" "wlc" {
  name              = "/my/${var.env}/wlc"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "wlc" {
  name           = "wlc"
  log_group_name = "${aws_cloudwatch_log_group.wlc.name}"
}
