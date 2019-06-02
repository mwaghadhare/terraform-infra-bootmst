resource "aws_cloudwatch_log_group" "papi-portal" {
  name              = "/my/${var.env}/papi-portal"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "papi-portal" {
  name           = "papi-portal"
  log_group_name = "${aws_cloudwatch_log_group.papi-portal.name}"
}
