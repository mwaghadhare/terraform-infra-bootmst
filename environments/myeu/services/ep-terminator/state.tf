terraform {
  backend "s3" {
    bucket   = "mysys-eu-tfstate"
    key      = "eu/services/ep-terminator/terraform.tfstate"
    region   = "eu-central-1"
    encrypt  = true
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
