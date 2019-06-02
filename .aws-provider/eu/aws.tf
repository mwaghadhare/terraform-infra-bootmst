provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::680464840752:role/terraform-create-role"
  }
}
