terraform {
  backend "s3" {
    bucket   = "mysys-us2-tfstate"
    key      = "eu/services/load-generator/terraform.tfstate"
    region   = "eu-central-1"
    encrypt  = true
    role_arn = "arn:aws:iam::593333452326:role/terraform-create-role"
    profile  = "default"
  }
}
