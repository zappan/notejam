data "aws_availability_zones" "all" {}

variable "region" {}
variable "env" {}
variable "vpc_cidr" {}
variable "subnet_bastions_count" { default = 2 }
variable "subnet_webservers_count" { default = 4 }
