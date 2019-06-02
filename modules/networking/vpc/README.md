AWS VPC Terraform module
========================

Terraform module which creates VPC resources on AWS.

These types of resources are supported:

* [VPC](https://www.terraform.io/docs/providers/aws/r/vpc.html)
* [Subnet](https://www.terraform.io/docs/providers/aws/r/subnet.html)
* [Route](https://www.terraform.io/docs/providers/aws/r/route.html)
* [Route table](https://www.terraform.io/docs/providers/aws/r/route_table.html)
* [Internet Gateway](https://www.terraform.io/docs/providers/aws/r/internet_gateway.html)
* [NAT Gateway](https://www.terraform.io/docs/providers/aws/r/nat_gateway.html)
* [VPC Endpoint](https://www.terraform.io/docs/providers/aws/r/vpc_endpoint.html) (S3 and DynamoDB)
* [RDS DB Subnet Group](https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html)

Usage
-----

```
module "testpad_vpc" {
     source             = "../../../modules/networking/vpc/"
     name               = "testpad-vpc"
     env                = "${var.env}"
     cidr               = "10.1.0.0/16"
     public_subnets     = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]
     private_subnets    = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
     db_subnets         = ["10.1.20.0/24", "10.1.21.0/24", "10.1.22.0/24"]
     azs                = "a,b,c"
     region             = "${var.region}"
     nat_gateways_count = 1
   }
```
