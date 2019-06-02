terraform {
  backend "s3" {
    bucket   = "myeu-tfstate"
    key      = "myeu/services/cloudwatch/terraform.tfstate"
    region   = "eu-west-1"
    encrypt  = true
    role_arn = "arn:aws:iam::8888xxxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
