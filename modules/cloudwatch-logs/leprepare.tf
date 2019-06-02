resource "aws_cloudwatch_log_group" "leprepare" {
  name              = "/my/${var.env}/leprepare"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "leprepare" {
  name           = "leprepare"
  log_group_name = "${aws_cloudwatch_log_group.leprepare.name}"
}
