module "networking" {
  source   = "../../modules/networking"
  region   = "${var.region}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
}

module "bastions" {
  source         = "../../modules/bastions"
  env            = "${var.env}"
  region         = "${var.region}"
  amis           = "${var.amis}"
  ssh_key_name   = "${var.ssh_key_name}"
  asg_min        = "${var.bastion_asg_min}"
  asg_max        = "${var.bastion_asg_max}"
  asg_desired    = "${var.bastion_asg_desired}"
  asg_subnet_ids = "${module.networking.bastion_subnet_ids}"
  bastion_sg_id  = "${module.networking.bastion_sg_id}"
}

module "application" {
  source          = "../../modules/application"
  env             = "${var.env}"
  region          = "${var.region}"
  amis            = "${var.amis}"
  ssh_key_name    = "${var.ssh_key_name}"
  asg_min         = "${var.webserver_asg_min}"
  asg_max         = "${var.webserver_asg_max}"
  asg_desired     = "${var.webserver_asg_desired}"
  asg_subnet_ids  = "${module.networking.webserver_subnet_ids}"
  webserver_sg_id = "${module.networking.webserver_sg_id}"
}
