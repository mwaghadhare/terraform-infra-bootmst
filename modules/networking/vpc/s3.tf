resource "aws_s3_bucket_policy" "assets-policy" {
  bucket = "my-${var.env}-assets"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1234567890123",
    "Statement": [
        {
            "Sid": "Stmt1234567890123",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::my-${var.env}-assets/*",
            "Condition": {
                "StringEquals": {
                    "aws:sourceVpc": [
                        "${aws_vpc.vpc.id}"
                    ]

                }
            }
        },
        {
            "Sid": "CircleCI",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::660610034966:root"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::my-${var.env}-assets/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "info-policy" {
  bucket = "my-${var.env}-info"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1234567890123",
    "Statement": [
       {
            "Sid": "Stmt1234567890123",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::my-${var.env}-info/*",
            "Condition": {
                "StringEquals": {
                    "aws:sourceVpc": [
                        "${aws_vpc.vpc.id}"
                    ]

                }
            }
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "elb-policy" {
  bucket = "my-${var.env}-elb-logs"

  policy = <<POLICY
{
      "Version": "2012-10-17",
      "Id": "Policy1234567890123",
      "Statement": [
          {
              "Sid": "Stmt1234567890123",
              "Effect": "Allow",
              "Principal": {
                  "AWS": "${var.aws_principal}"
              },
              "Action": "s3:PutObject",
              "Resource": "arn:aws:s3:::my-${var.env}-elb-logs/*"
          }
      ]
}
POLICY
}

resource "aws_s3_bucket_policy" "iptun-policy" {
  bucket = "my-iptun-${var.env}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1234567890123",
    "Statement": [
       {
            "Sid": "Stmt1234567890123",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::my-iptun-${var.env}/*",
            "Condition": {
                "StringEquals": {
                    "aws:sourceVpc": [
                        "${aws_vpc.vpc.id}"
                    ]

                }
            }
        }
    ]
}
POLICY
}


resource "aws_s3_bucket_policy" "manage-policy" {
  bucket = "manage.${var.env}.${var.domain}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": ["s3:GetObject","s3:PutObject"],
            "Resource": "arn:aws:s3:::manage.${var.env}.${var.domain}/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket_policy" "status-policy" {
  bucket = "status.${var.env}.${var.domain}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": ["s3:GetObject","s3:PutObject"],
            "Resource": "arn:aws:s3:::status.${var.env}.${var.domain}/*"
        }
    ]
}
POLICY
}




resource "aws_s3_bucket_policy" "papi-policy" {
  bucket = "papi-${var.env}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "PutObjPolicy",
    "Statement": [
        {
            "Sid": "ForceSSLOnlyAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::papi-${var.env}/*",
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            }
        }
    ]
}
POLICY
}
