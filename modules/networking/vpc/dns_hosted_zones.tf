resource "aws_route53_zone" "private_zone" {
  count   = "${var.private_zone_create}"
  name    = "${var.private_domain}"
  vpc_id  = "${aws_vpc.vpc.id}"
  comment = "${var.name} private zone for ${var.env}"

  tags {
    Name        = "${var.name}.${var.env}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

resource "aws_route53_zone" "public_zone" {
  count   = "${var.public_zone_create}"
  name    = "${var.name}.${var.env}.${var.public_domain}"
  comment = "${var.name}.${var.env} public zone"

  tags {
    Name        = "${var.name}.${var.env}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}
