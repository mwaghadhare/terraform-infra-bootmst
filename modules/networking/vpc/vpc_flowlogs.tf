resource "aws_cloudwatch_log_group" "flow_log_group" {
  count             = "${var.flow_log_enabled}"
  name              = "vpc-flow-logs/${var.name}"
  retention_in_days = "${var.flow_log_days}"
}

resource "aws_iam_role" "flow_log_role" {
  count = "${var.flow_log_enabled}"
  name  = "vpc-flow-logs-${var.name}-${var.env}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": {
      "Service": "vpc-flow-logs.amazonaws.com"
    },
    "Effect": "Allow"
  }]
}
EOF
}

resource "aws_iam_role_policy" "flow_log_role_policies" {
  count = "${var.flow_log_enabled}"
  name  = "logs"
  role  = "${aws_iam_role.flow_log_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ],
    "Effect": "Allow",
    "Resource": "${aws_cloudwatch_log_group.flow_log_group.arn}"
  }]
}
EOF
}

resource "aws_flow_log" "flow_log" {
  count          = "${var.flow_log_enabled}"
  log_group_name = "${aws_cloudwatch_log_group.flow_log_group.name}"
  iam_role_arn   = "${aws_iam_role.flow_log_role.arn}"
  vpc_id         = "${aws_vpc.vpc.id}"
  traffic_type   = "${var.flow_log_traffic_type}"
}
