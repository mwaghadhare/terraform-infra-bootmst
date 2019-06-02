provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::888888xxxxxxxx:role/terraform-create-role"
  }
}
