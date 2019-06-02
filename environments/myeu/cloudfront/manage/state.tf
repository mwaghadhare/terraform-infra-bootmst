terraform {
  backend "s3" {
    bucket   = "myeu-tfstate"
    key      = "myeu/cloudfront/terraform.tfstate"
    region   = "eu-west-1"
    encrypt  = true
    role_arn = "arn:aws:iam::888xxxxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
