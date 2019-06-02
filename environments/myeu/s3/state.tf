terraform {
  backend "s3" {
    bucket   = "mysys-eu-tfstate"
    key      = "eu/s3/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
    encrypt  = true
  }
}
