resource "aws_cloudwatch_log_group" "location" {
  name              = "/my/${var.env}/location"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "location" {
  name           = "location"
  log_group_name = "${aws_cloudwatch_log_group.location.name}"
}
