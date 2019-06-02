data "archive_file" "route_53" {
  type        = "zip"
  source_file = "${path.module}/route53.py"
  output_path = "${path.module}/delete_route.zip"
}

resource "aws_lambda_function" "delete_route53" {
  filename         = "${path.module}/delete_route.zip"
  function_name    = "delete_route_53"
  role             = "${aws_iam_role.delete-route53-role.arn}"
  handler          = "route53.lambda_handler"
  source_code_hash = "${data.archive_file.route_53.output_base64sha256}"
  runtime          = "python3.6"
}

resource "aws_iam_role" "delete-route53-role" {
  name  = "delete-route53-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "delete-route53_iam_policy" {
  name        = "delete-route53-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:*",
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "delete-route53_policy_attach" {
  role       = "${aws_iam_role.delete-route53-role.name}"
  policy_arn = "${aws_iam_policy.delete-route53_iam_policy.arn}"
}

resource "aws_cloudwatch_event_rule" "ec2-stopped" {
  name        = "capture-ec2-stopped-events"
  description = "Capture all EC2 stopped events"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.ec2"
  ],
  "detail-type": [
    "EC2 Instance State-change Notification"
  ],
  "detail": {
    "state": [
      "stopped",
      "terminated"
    ]
  }
}
PATTERN
}


resource "aws_cloudwatch_event_target" "ec2-stopped-target" {
    rule = "${aws_cloudwatch_event_rule.ec2-stopped.name}"
    target_id = "EC2-stopped"
    arn = "${aws_lambda_function.delete_route53.arn}"
}


resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda_function" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.delete_route53.function_name}"
    principal = "events.amazonaws.com"
    source_arn = "${aws_cloudwatch_event_rule.ec2-stopped.arn}"
}
