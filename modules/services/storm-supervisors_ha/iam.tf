variable "org" {
  default     = "mysys"
  description = "Internal variable for role names"
}

resource "aws_iam_instance_profile" "storm-supervisors_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-iam-ha"
  role  = "${aws_iam_role.storm-supervisors_iam_role.name}"
}

resource "aws_iam_role" "storm-supervisors_iam_role" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-ha"

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

resource "aws_iam_policy" "storm-supervisors_iam_policy" {
  count       = "${var.instance_profile == "" ? 1 : 0}"
  name        = "${var.org}-${var.env}-${var.name}-ha"
  description = "Policy for ${var.org}-${var.env}-${var.name} role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "S3:List*",
                "S3:Get*",
                "S3:*"
            ],
            "Resource": [
                "arn:aws:s3:::my-${var.env}-assets/*",
                "arn:aws:s3:::my-${var.env}-info/*",
                "arn:aws:s3:::ap-logs-${var.env}/*"
            ]
        },
        {
         "Effect": "Allow",
         "Action": [
            "route53:CreateHostedZone",
            "route53:UpdateHostedZoneComment",
            "route53:GetHostedZone",
            "route53:ListHostedZones",
            "route53:DeleteHostedZone",
            "route53:ChangeResourceRecordSets",
            "route53:ListResourceRecordSets",
            "route53:GetHostedZoneCount",
            "route53:ListHostedZonesByName"
         ],
         "Resource": "*"
      },
       {
               "Effect" : "Allow",
               "Action" :
                    [
                         "ec2:CreateTags",
                         "ec2:DeleteTags"
                    ],
               "Resource" : "*"
          }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "storm-supervisors_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.storm-supervisors_iam_role.name}"
  policy_arn = "${aws_iam_policy.storm-supervisors_iam_policy.arn}"
}
