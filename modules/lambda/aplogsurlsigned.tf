data "archive_file" "init" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/init.zip"
}

resource "aws_lambda_function" "ap_logs_lambda" {
  filename         = "${path.module}/init.zip"
  function_name    = "test_lambda"
  role             = "${aws_iam_role.ap-logs-role.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.init.output_base64sha256}"
  runtime          = "nodejs6.10"
}

resource "aws_iam_role" "ap-logs-role" {
  name  = "ap-logs-role"

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

resource "aws_iam_policy" "ap-logs_iam_policy" {
  name        = "ap-logs-policy"

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
                "arn:aws:s3:::ap-logs-qadeer/*"
            ]
        },
        {
         "Effect": "Allow",
         "Action": [
            "S3:*"
         ],
         "Resource": [
             "arn:aws:s3:::ap-logs-qadeer"
          ]

      },
       {
               "Effect" : "Allow",
               "Action" :
                    [
                 "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"                         
                    ],
               "Resource" : "*"
          }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ap-logs_policy_attach" {
  role       = "${aws_iam_role.ap-logs-role.name}"
  policy_arn = "${aws_iam_policy.ap-logs_iam_policy.arn}"
}

resource "aws_api_gateway_rest_api" "SignedAPUrls" {
  name        = "SignedAPUrls "
}

resource "aws_api_gateway_resource" "ap-logs-resource" {
  rest_api_id = "${aws_api_gateway_rest_api.SignedAPUrls.id}"
  parent_id   = "${aws_api_gateway_rest_api.SignedAPUrls.root_resource_id}"
  path_part   = "{qadeer-ap-logs}"
}

resource "aws_api_gateway_method" "ap-logs-method" {
  rest_api_id   = "${aws_api_gateway_rest_api.SignedAPUrls.id}"
  resource_id   = "${aws_api_gateway_resource.ap-logs-resource.id}"
  http_method   = "POST"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.SignedAPUrls.id}"
  resource_id = "${aws_api_gateway_method.ap-logs-method.resource_id}"
  http_method = "${aws_api_gateway_method.ap-logs-method.http_method}"

  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:eu-central-1:lambda:path/2015-03-31/functions/${aws_lambda_function.ap_logs_lambda.arn}/invocat
ions"
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.ap_logs_lambda.arn}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:eu-central-1:8888xxxxx:${aws_api_gateway_rest_api.SignedAPUrls.id}/*/${aws_api_gateway_method.ap-logs-me
thod.http_method}${aws_api_gateway_resource.ap-logs-resource.path}"
}


resource "aws_api_gateway_method_response" "200" {
  rest_api_id = "${aws_api_gateway_rest_api.SignedAPUrls.id}"
  resource_id = "${aws_api_gateway_resource.ap-logs-resource.id}"
  http_method = "${aws_api_gateway_method.ap-logs-method.http_method}"
  status_code = "200"
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "true" }
  response_models = { "application/json" = "Empty" }
}


resource "aws_api_gateway_integration_response" "IntegrationResponse" {
  rest_api_id = "${aws_api_gateway_rest_api.SignedAPUrls.id}"
  resource_id = "${aws_api_gateway_resource.ap-logs-resource.id}"
  http_method = "${aws_api_gateway_method.ap-logs-method.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'https://manage.qadeer.my.zone'"
  }
  response_templates = { "application/json" = "Empty" }
}
