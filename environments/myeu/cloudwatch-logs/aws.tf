provider "aws" {
  region = "${var.region}"

  assume_role {
    role_arn = "arn:aws:iam::8888xxxxxx:role/terraform-create-role"
  }
}
