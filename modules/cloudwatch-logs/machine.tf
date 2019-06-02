resource "aws_cloudwatch_log_group" "machine" {
  name              = "/my/${var.env}/machine"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "machine" {
  name           = "machine"
  log_group_name = "${aws_cloudwatch_log_group.machine.name}"
}
