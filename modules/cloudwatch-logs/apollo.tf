resource "aws_cloudwatch_log_group" "apollo" {
  name              = "/my/${var.env}/apollo"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "apollo" {
  name           = "apollo"
  log_group_name = "${aws_cloudwatch_log_group.apollo.name}"
}
