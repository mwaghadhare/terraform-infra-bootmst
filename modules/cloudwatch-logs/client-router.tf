resource "aws_cloudwatch_log_group" "client-router" {
  name              = "/my/${var.env}/client-router"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "client-router" {
  name           = "client-router"
  log_group_name = "${aws_cloudwatch_log_group.client-router.name}"
}
