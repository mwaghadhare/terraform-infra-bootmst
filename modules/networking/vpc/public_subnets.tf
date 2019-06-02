## Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${signum(length(var.public_subnets))}"

  tags {
    Name        = "${var.name}-igw"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

## Public subnet/s
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.public_subnets[count.index]}"
  availability_zone       = "${element(split(",", var.azs), count.index)}"
  count                   = "${length(var.public_subnets)}"
  map_public_ip_on_launch = true

  tags {
    Name        = "${var.name}-public-${element(split(",", var.azs), count.index)}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${signum(length(var.public_subnets))}"

  tags {
    Name        = "${var.name}-public"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }
}

resource "aws_route" "default" {
  count                  = "${signum(length(var.public_subnets))}"
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
