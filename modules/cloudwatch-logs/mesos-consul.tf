resource "aws_cloudwatch_log_group" "mesos-consul" {
  name              = "/my/${var.env}/mesos-consul"
  retention_in_days = "30"
}

resource "aws_cloudwatch_log_stream" "mesos-consul" {
  name           = "mesos-consul"
  log_group_name = "${aws_cloudwatch_log_group.mesos-consul.name}"
}
