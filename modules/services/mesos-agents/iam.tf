variable "org" {
  default     = "mysys"
  description = "Internal variable for role names"
}

resource "aws_iam_instance_profile" "mesos-agents_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-iam"
  role  = "${aws_iam_role.mesos-agents_iam_role.name}"
}

resource "aws_iam_role" "mesos-agents_iam_role" {
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

resource "aws_iam_policy" "mesos-agents_iam_policy" {
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
                "S3:List*",
                "S3:Get*",
                "S3:*"
            ],
            "Resource": [
                "arn:aws:s3:::my-${var.env}-assets",
                "arn:aws:s3:::my-${var.env}-assets/*",
                "arn:aws:s3:::my-iptun-${var.env}",
                "arn:aws:s3:::my-iptun-${var.env}/*",
                "arn:aws:s3:::my-${var.env}-info",
                "arn:aws:s3:::my-${var.env}-info/*",
                "arn:aws:s3:::my-${var.env}-kafka-backup",
                "arn:aws:s3:::my-${var.env}-kafka-backup/*",
                "arn:aws:s3:::ap-logs-${var.env}",
                "arn:aws:s3:::ap-logs-${var.env}/*",
                "arn:aws:s3:::papi-${var.env}",
                "arn:aws:s3:::papi-${var.env}/*"
            ]
        },
        {
            "Sid": "AllowDizzy2FirmwareList",
            "Effect": "Allow",
            "Action": [
                "S3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::firmware.my.com"
            ]
        },
        {
            "Sid": "AllowDizzy2FirmwareDownloads",
            "Effect": "Allow",
            "Action": [
                "S3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::firmware.my.com/*"
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
         "Effect": "Allow",
         "Action": [
           "logs:CreateLogGroup",
           "logs:CreateLogStream",
           "logs:DeleteLogGroup",
           "logs:DeleteLogStream",
           "logs:PutLogEvents",
           "logs:PutMetricFilter",
           "logs:DescribeLogGroups",
           "logs:DescribeLogStreams"
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

resource "aws_iam_role_policy_attachment" "mesos-agents_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.mesos-agents_iam_role.name}"
  policy_arn = "${aws_iam_policy.mesos-agents_iam_policy.arn}"
}
