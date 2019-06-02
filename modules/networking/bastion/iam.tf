variable "bastion" {
  default = "bastion"
}

variable "org" {
  default = "mysys"
}

resource "aws_iam_instance_profile" "bastion_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.bastion}-iam"
  role  = "${aws_iam_role.bastion_iam_role.name}"
}

resource "aws_iam_role" "bastion_iam_role" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.bastion}"

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

resource "aws_iam_policy" "bastion_iam_policy" {
  count       = "${var.instance_profile == "" ? 1 : 0}"
  name        = "${var.org}-${var.env}-${var.bastion}"
  description = "Default policy for ${var.org}-${var.env}-${var.bastion} role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                 "s3:List*",
                 "s3:Get*"
            ],
            "Resource": [
                 "arn:aws:s3:::my-${var.env}-info",
                 "arn:aws:s3:::my-${var.env}-info/keys",
                 "arn:aws:s3:::my-${var.env}-info/keys/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "bastion_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.bastion_iam_role.name}"
  policy_arn = "${aws_iam_policy.bastion_iam_policy.arn}"
}
