resource "aws_cloudwatch_log_group" "zones" {
  name              = "/my/${var.env}/zones"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "zones" {
  name           = "zones"
  log_group_name = "${aws_cloudwatch_log_group.zones.name}"
}
