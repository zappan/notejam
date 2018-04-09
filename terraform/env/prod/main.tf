module "networking" {
  source   = "../../modules/networking"
  region   = "${var.region}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"
}

# module "database" {
#   source              = "../../modules/database"
#   env                 = "${var.env}"
#   rds_sg_id           = "${module.networking.rds_sg_id}"
#   rds_subnetgroup_ids = "${module.networking.webserver_subnet_ids}"
# }

module "bastions" {
  source             = "../../modules/bastions"
  env                = "${var.env}"
  region             = "${var.region}"
  amis               = "${var.default_amis}"
  ssh_key_name       = "${var.ssh_key_name}"
  asg_min            = "${var.bastion_asg_min}"
  asg_max            = "${var.bastion_asg_max}"
  asg_desired        = "${var.bastion_asg_desired}"
  bastion_subnet_ids = "${module.networking.bastion_subnet_ids}"
  bastion_sg_id      = "${module.networking.bastion_sg_id}"
  datadog_api_key    = "${var.datadog_api_key}"
}

module "application" {
  source                = "../../modules/application"
  env                   = "${var.env}"
  region                = "${var.region}"
  amis                  = "${var.webserver_amis}"
  ssh_key_name          = "${var.ssh_key_name}"
  asg_min               = "${var.webserver_asg_min}"
  asg_max               = "${var.webserver_asg_max}"
  asg_desired           = "${var.webserver_asg_desired}"
  efs_sg_id             = "${module.networking.efs_sg_id}"
  webserver_subnet_ids  = "${module.networking.webserver_subnet_ids}"
  webserver_sg_id       = "${module.networking.webserver_sg_id}"
  webserver_iam_profile = "${var.webserver_iam_profile}"
  deployment_app_name         = "${var.deployment_app_name}"
  deployment_option           = "${var.deployment_option}"
  deployment_service_role_arn = "${var.codedeploy_role_arn}"
  datadog_api_key             = "${var.datadog_api_key}"
}

# module "loadbalancer" {
#   source             = "../../modules/loadbalancer"
#   env                = "${var.env}"
#   app_name           = "${var.app_name}"
#   alb_vpc_id         = "${module.networking.vpc_id}"
#   alb_sg_id          = "${module.networking.alb_sg_id}"
#   alb_subnet_ids     = "${module.networking.webserver_subnet_ids}"
#   alb_servers_asg_id = "${module.application.webservers_asg_id}"
# }
