## Private subnet/s
resource "aws_subnet" "db" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.db_subnets[count.index]}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(var.db_subnets)}"

  tags {
    Name        = "${var.name}-db-${element(split(",", var.azs), count.index)}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}
