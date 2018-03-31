module "networking" {
  source   = "../../modules/networking"
  region   = "${var.region}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
}

module "bastions" {
  source        = "../../modules/bastions"
  env           = "${var.env}"
  region        = "${var.region}"
  amis          = "${var.amis}"
  ssh_key_name  = "${var.ssh_key_name}"
  bastion_sg_id = "${module.networking.bastion_sg_id}"
}

module "application" {
  source          = "../../modules/application"
  env             = "${var.env}"
  region          = "${var.region}"
  amis            = "${var.amis}"
  ssh_key_name    = "${var.ssh_key_name}"
  webserver_sg_id = "${module.networking.webserver_sg_id}"
}
