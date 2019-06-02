resource "aws_vpc_endpoint" "vpc-endpoint" {
  vpc_id          = "${aws_vpc.vpc.id}"
  service_name    = "${var.service_name}"
  route_table_ids = ["${aws_route_table.public.id}", "${aws_route_table.private.*.id}"]

  policy = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
}
