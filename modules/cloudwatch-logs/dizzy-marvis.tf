resource "aws_cloudwatch_log_group" "dizzy-marvis" {
  name              = "/my/${var.env}/dizzy-marvis"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "dizzy-marvis" {
  name           = "dizzy-marvis"
  log_group_name = "${aws_cloudwatch_log_group.dizzy-marvis.name}"
}
