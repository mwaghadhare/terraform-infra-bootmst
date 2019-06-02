resource "aws_cloudwatch_log_group" "papi" {
  name              = "/my/${var.env}/papi"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "papi" {
  name           = "papi"
  log_group_name = "${aws_cloudwatch_log_group.papi.name}"
}
