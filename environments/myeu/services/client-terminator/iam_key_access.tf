# Create the key access role and policy
# This is so that the key access role can be passed down
# Granting this primarily to the ep-term means any shell account
# in the machine will get the instance policy and will be able
# to decrypt keys
resource "aws_iam_role" "client-terminator-key-access" {
  name = "${var.org}-${var.env}-${var.name}-key-access"

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
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.client-terminator_iam_role.arn}"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "client-terminator_key_access_policy" {
  name        = "${var.org}-${var.env}-${var.name}-key-access"
  description = "Policy for ${var.org}-${var.env}-${var.name} key-access role"

  # Hard coding the parameter store info for clarity for the time being
  # TODO: refactor into the module in future
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowDescribingParams",
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowReadingParamsFromEPTerminator",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters"
            ],
            "Resource": [
                "arn:aws:ssm:eu-central-1:8888xxxxx:parameter/my/${var.env}/client-terminator*"
            ]
        },
        {
            "Sid": "AllowDecryptingWithKeyID",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "${var.kms_key_id}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "client-terminator_key_access_policy_attach" {
  role       = "${aws_iam_role.client-terminator-key-access.name}"
  policy_arn = "${aws_iam_policy.client-terminator_key_access_policy.arn}"
}

# Leaving this here for clarity, if this is in module, you want to write
# out the arn of the key access role
output "client-terminator-key-access" {
  value = "${aws_iam_role.client-terminator-key-access.arn}"
}
