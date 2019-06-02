resource "aws_cloudwatch_log_group" "dizzy" {
  name              = "/my/${var.env}/dizzy"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "dizzy" {
  name           = "dizzy"
  log_group_name = "${aws_cloudwatch_log_group.dizzy.name}"
}
