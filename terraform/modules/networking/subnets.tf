# Public subnets for Bastion hosts + DMZ Route Table association
resource "aws_subnet" "bastion_subnets" {
  count             = "${var.subnet_bastions_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 12, 16*255 + count.index)}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  tags {
    Name = "${var.env}-bastion-${count.index + 1}"
    env  = "${var.env}"
  }
}

resource "aws_route_table_association" "bastion_subnets_associations" {
  count          = "${var.subnet_bastions_count}"
  subnet_id      = "${element(aws_subnet.bastion_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.dmz_route_table.id}"
}


# Private subnets for Web servers + DMZ Route Table association
resource "aws_subnet" "webserver_subnets" {
  count             = "${var.subnet_webservers_count}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.all.names, count.index)}"
  tags {
    Name = "${var.env}-webapp-${count.index + 1}"
    env  = "${var.env}"
  }
}

resource "aws_route_table_association" "webserver_subnets_associations" {
  count          = "${var.subnet_webservers_count}"
  subnet_id      = "${element(aws_subnet.webserver_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.dmz_route_table.id}"
}
