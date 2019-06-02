## Private subnet/s
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(var.private_subnets)}"

  tags {
    Name        = "${var.name}-private-${element(split(",", var.azs), count.index)}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${length(var.private_subnets)}"

  tags {
    Name        = "${var.name}-private-${element(split(",", var.azs), count.index)}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  count          = "${length(var.private_subnets)}"
}

## NAT gateway
resource "aws_eip" "nat" {
  count = "${var.nat_gateways_count * signum(length(var.private_subnets))}"
  vpc   = true
}

resource "aws_route" "nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  count                  = "${length(var.private_subnets) * signum(var.nat_gateways_count)}"
  depends_on             = ["aws_route_table.private"]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${var.nat_gateways_count * signum(length(var.private_subnets))}"
}
