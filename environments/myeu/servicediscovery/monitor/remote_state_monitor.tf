data "terraform_remote_state" "monitor" {
  backend = "s3"

  config {
    bucket   = "mysys-eu-tfstate"
    key      = "eu/services/monitor/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
