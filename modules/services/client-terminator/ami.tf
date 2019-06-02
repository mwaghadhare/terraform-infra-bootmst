data "aws_ami" "client-terminator" {
  most_recent = true

  filter {
    name   = "name"
    values = ["client-terminator*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["8xxxxxxxxxx"] # My
}
