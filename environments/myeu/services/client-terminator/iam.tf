variable "instance_profile" {
  description = "The IAM Instance Profile to launch the instances with; if undefined the module will create one"
  default     = ""
}

resource "aws_iam_instance_profile" "client-terminator_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-iam"
  role  = "${aws_iam_role.client-terminator_iam_role.name}"
}

resource "aws_iam_role" "client-terminator_iam_role" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }

  ]
}
EOF
}

resource "aws_iam_policy" "client-terminator_iam_policy" {
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
                "arn:aws:s3:::ap-logs-${var.env}",
                "arn:aws:s3:::ap-logs-${var.env}/*"
            ]
        },
        {
            "Sid": "AllowListBucketEssentials",
            "Effect": "Allow",
            "Action": [
                "S3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::my-tools",
                "arn:aws:s3:::my-iptun-${var.env}"
            ]
        },
        {
            "Sid": "AllowDeploymentManifestAccess",
            "Effect": "Allow",
            "Action": [
                "S3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::my-tools/deployments/*"
            ]
       },
       {
          "Sid": "GrantAccessToIPTunUpdates",
          "Effect": "Allow",
          "Action": [
             "S3:GetObject",
             "S3:PutObject"
          ],
          "Resource": [
             "arn:aws:s3:::my-iptun-${var.env}/iptun-routes/*"
          ]
       }
      ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "client-terminator_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.client-terminator_iam_role.name}"
  policy_arn = "${aws_iam_policy.client-terminator_iam_policy.arn}"
}
