module "networking" {
  source   = "../../modules/networking"
  region   = "${var.region}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
  subnet_webservers_count = 2
}
