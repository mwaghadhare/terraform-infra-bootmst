provider "aws" {
  region = "${var.region}"
  skip_requesting_account_id  = true # this can be tricky
  skip_get_ec2_platforms      = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true
  assume_role {
    role_arn = "arn:aws:iam::593333452326:role/terraform-create-role"
  }
}
