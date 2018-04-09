# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name = "${var.env}VPC"
    env  = "${var.env}"
  }
}

# Default Route Table - tagging
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  tags {
    Name = "${var.env}-Default-RT"
    env  = "${var.env}"
  }
}

# DMZ Route Table
resource "aws_route_table" "dmz_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.env}-DMZ-RT"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.env}IGW"
    env  = "${var.env}"
  }
}
