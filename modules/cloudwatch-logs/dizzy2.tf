resource "aws_cloudwatch_log_group" "dizzy2" {
  name              = "/my/${var.env}/dizzy2"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "dizzy2" {
  name           = "dizzy2"
  log_group_name = "${aws_cloudwatch_log_group.dizzy2.name}"
}
