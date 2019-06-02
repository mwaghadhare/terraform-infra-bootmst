data "aws_ami" "ep-terminator" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ep-terminator*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["831168860538"] # my
}
