variable "org" {
  default     = "mysys"
  description = "Internal variable for role names"
}

resource "aws_iam_instance_profile" "jenkins_iam_profile" {
  count = "${var.instance_profile == "" ? 1 : 0}"
  name  = "${var.org}-${var.env}-${var.name}-iam"
  role  = "${aws_iam_role.jenkins_iam_role.name}"
}

resource "aws_iam_role" "jenkins_iam_role" {
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

resource "aws_iam_policy" "jenkins_iam_policy" {
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
                "s3:List*",
                "s3:Get*",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::my-${var.env}-info",
                "arn:aws:s3:::my-${var.env}-info/*",
                "arn:aws:s3:::manage-${var.env}-my.com",
                "arn:aws:s3:::manage-${var.env}-my.com/*",
                "arn:aws:s3:::my-topology",
                "arn:aws:s3:::my-topology/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
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

resource "aws_iam_policy" "jenkins_iam_policy_UI_bucket_upload" {
  count       = "${var.instance_profile == "" ? 1 : 0}"
  name        = "${var.org}-${var.env}-${var.name}-ui-bucket-upload"
  description = "Policy for ${var.org}-${var.env}-${var.name} ui bucket upload role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "cloudfront:GetDistribution",
                  "cloudfront:ListCloudFrontOriginAccessIdentities",
                  "cloudfront:ListInvalidations",
                  "cloudfront:ListDistributions",
                  "cloudfront:UpdateDistribution",
                  "cloudfront:ListStreamingDistributions",
                  "cloudfront:CreateInvalidation",
                  "cloudfront:ListDistributionsByWebACLId"
              ],
              "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                  "s3:ListBucketByTags",
                  "s3:GetLifecycleConfiguration",
                  "s3:GetBucketTagging",
                  "s3:GetInventoryConfiguration",
                  "s3:GetObjectVersionTagging",
                  "s3:ListBucketVersions",
                  "s3:GetBucketLogging",
                  "s3:ListBucket",
                  "s3:GetAccelerateConfiguration",
                  "s3:GetBucketPolicy",
                  "s3:GetObjectVersionTorrent",
                  "s3:GetObjectAcl",
                  "s3:GetEncryptionConfiguration",
                  "s3:GetBucketRequestPayment",
                  "s3:GetObjectVersionAcl",
                  "s3:GetObjectTagging",
                  "s3:GetMetricsConfiguration",
                  "s3:DeleteObject",
                  "s3:GetIpConfiguration",
                  "s3:PutObjectAcl",
                  "s3:ListBucketMultipartUploads",
                  "s3:GetBucketWebsite",
                  "s3:GetBucketVersioning",
                  "s3:GetBucketAcl",
                  "s3:GetBucketNotification",
                  "s3:GetReplicationConfiguration",
                  "s3:ListMultipartUploadParts",
                  "s3:GetObject",
                  "s3:GetObjectTorrent",
                  "s3:GetBucketCORS",
                  "s3:GetAnalyticsConfiguration",
                  "s3:GetObjectVersionForReplication",
                  "s3:GetBucketLocation",
                  "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::manage.${var.env}.${var.domain}",
                "arn:aws:s3:::manage.${var.env}.${var.domain}/*",
                "arn:aws:s3:::status.${var.env}.${var.domain}",
                "arn:aws:s3:::status.${var.env}.${var.domain}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jenkins_policy_attach" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.jenkins_iam_role.name}"
  policy_arn = "${aws_iam_policy.jenkins_iam_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "jenkins_policy_attach_ui_bucekt" {
  count      = "${var.instance_profile == "" ? 1 : 0}"
  role       = "${aws_iam_role.jenkins_iam_role.name}"
  policy_arn = "${aws_iam_policy.jenkins_iam_policy_UI_bucket_upload.arn}"
}
