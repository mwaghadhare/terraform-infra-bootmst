data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket   = "mysys-us2-tfstate"
    key      = "eu/vpc/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::593333452326:role/terraform-create-role"
    profile  = "default"
  }
}
