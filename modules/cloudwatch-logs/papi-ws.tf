resource "aws_cloudwatch_log_group" "papi_ws" {
  name              = "/my/${var.env}/papi_ws"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "papi_ws" {
  name           = "papi_ws"
  log_group_name = "${aws_cloudwatch_log_group.papi_ws.name}"
}
