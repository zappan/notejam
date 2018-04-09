# Default SG - allows inbound within itself, and all outbound traffic
resource "aws_default_security_group" "default_sg" {
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-Default-SG"
  }
}

# ALB SG - allows all HTTP & HTTPS inbound, and all outbound traffic
resource "aws_security_group" "alb_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.env}-ALB-SG"
  description = "Application Load Balancers SG"
  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-ALB-SG"
  }
}

# EFS SG - allows Web Servers EFS inbound, and all outbound traffic
resource "aws_security_group" "efs_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.env}-EFS-SG"
  description = "EFS SG"
  ingress {
    protocol        = "tcp"
    from_port       = 2049
    to_port         = 2049
    security_groups = ["${aws_security_group.webserver_sg.id}"]
    description     = "Web Servers access to EFS"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-EFS-SG"
  }
}

# Bastions SG - allows all SSH inbound, and all outbound traffic
resource "aws_security_group" "bastion_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.env}-Bastion-SG"
  description = "Bastion Hosts SG"
  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-Bastion-SG"
  }
}

# WebServers SG - allows
# * SSH inbound from Bastions
# * all HTTP & HTTPS inbound, plus from the Load Balancers
# * all outbound traffic
resource "aws_security_group" "webserver_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.env}-WebServer-SG"
  description = "Web Servers SG"
  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = ["${aws_security_group.bastion_sg.id}"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }
  ingress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-WebServer-SG"
  }
}

# RDS SG - allows Web Servers MySQL inbound, and all outbound traffic
resource "aws_security_group" "rds_sg" {
  vpc_id      = "${aws_vpc.vpc.id}"
  name        = "${var.env}-RDS-SG"
  description = "RDS SG"
  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = ["${aws_security_group.webserver_sg.id}"]
    description     = "Web Servers access to RDS"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.env}-RDS-SG"
  }
}
