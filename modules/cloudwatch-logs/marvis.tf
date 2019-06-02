resource "aws_cloudwatch_log_group" "marvis" {
  name              = "/my/${var.env}/marvis"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "marvis" {
  name           = "marvis"
  log_group_name = "${aws_cloudwatch_log_group.marvis.name}"
}
