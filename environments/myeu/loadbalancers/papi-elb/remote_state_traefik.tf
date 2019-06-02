data "terraform_remote_state" "traefik-papi" {
  backend = "s3"

  config {
    bucket   = "mysys-eu-tfstate"
    key      = "eu/loadbalancers/traefik-papi/terraform.tfstate"
    region   = "eu-central-1"
    role_arn = "arn:aws:iam::8888xxxxx:role/terraform-create-role"
    profile  = "default"
  }
}
