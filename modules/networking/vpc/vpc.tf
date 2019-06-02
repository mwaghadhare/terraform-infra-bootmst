#------------------------------------------------------------------------------------------------------#
#Code to create AWS VPC.                                                                               #
#------------------------------------------------------------------------------------------------------#

# Create AWS VPC
# Note:  should add more tags!

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.region}-${var.env}"
    ENV  = "${var.env}"
  }
}
