data "terraform_remote_state" "predixy" {
  backend = "s3"

  config {
    bucket   = "mysys-eu-tfstate"
    key      = "eu/services/predixy/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
