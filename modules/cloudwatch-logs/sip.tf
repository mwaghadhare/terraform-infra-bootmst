resource "aws_cloudwatch_log_group" "sip" {
  name              = "/my/${var.env}/sip"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "sip" {
  name           = "sip"
  log_group_name = "${aws_cloudwatch_log_group.sip.name}"
}
