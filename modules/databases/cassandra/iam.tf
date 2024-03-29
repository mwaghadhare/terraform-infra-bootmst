variable "org" {
  default     = "mysys"
  description = "Internal variable for role names"
}

resource "aws_iam_instance_profile" "cassandra_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-iam"
  role  = "${aws_iam_role.cassandra_iam_role.name}"
}

resource "aws_iam_role" "cassandra_iam_role" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cassandra_iam_policy" {
  count       = "${var.instance_profile == "" ? 1 : 0}"
  name        = "${var.org}-${var.env}-${var.name}"
  description = "Policy for ${var.org}-${var.env}-${var.name} role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ec2:CreateTags"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "s3:Get*",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::my-${var.env}-info",
                "arn:aws:s3:::my-${var.env}-info/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cassandra_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.cassandra_iam_role.name}"
  policy_arn = "${aws_iam_policy.cassandra_iam_policy.arn}"
}
