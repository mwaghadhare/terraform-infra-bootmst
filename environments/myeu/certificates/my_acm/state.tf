terraform {
  backend "s3" {
    bucket   = "mybucket-myeu-tfstate"
    key      = "myeu/certificates/my-acm/terraform.tfstate"
    region   = "eu-west-1"
    encrypt  = true
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
