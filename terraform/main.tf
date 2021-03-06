terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  # backend "s3" {
  #   bucket  = "toptal.devops"
  #   key     = "terraform.tfstate"
  #   region  = "us-east-1"
  #   profile = "toptaldevopsadmin"
  # }
}

provider "aws" {
  region  = "${var.region}"
  profile = "toptaldevopsadmin"
}

module "global" {
  source              = "./env/_global"
  region              = "${var.region}"
  ssh_key_name        = "${var.ssh_key_name}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
  deployment_app_name = "${local.deployment_app_name}"
}

module "devEnvironment" {
  source                = "./env/dev"
  region                = "${var.region}"
  default_amis          = "${local.default_amis}"
  webserver_amis        = "${local.webserver_amis}"
  ssh_key_name          = "${var.ssh_key_name}"
  app_name              = "${local.app_name}"
  deployment_app_name   = "${local.deployment_app_name}"
  deployment_option     = "WITHOUT_TRAFFIC_CONTROL"
  codedeploy_role_arn   = "${module.global.codedeploy_role_arn}"
  webserver_iam_profile = "${module.global.webserver_iam_profile}"
  datadog_api_key       = "${local.datadog_api_key}"
}

module "prodEnvironment" {
  source                = "./env/prod"
  region                = "${var.region}"
  default_amis          = "${local.default_amis}"
  webserver_amis        = "${local.webserver_amis}"
  ssh_key_name          = "${var.ssh_key_name}"
  app_name              = "${local.app_name}"
  deployment_app_name   = "${local.deployment_app_name}"
  deployment_option     = "WITHOUT_TRAFFIC_CONTROL"
  codedeploy_role_arn   = "${module.global.codedeploy_role_arn}"
  webserver_iam_profile = "${module.global.webserver_iam_profile}"
  datadog_api_key       = "${local.datadog_api_key}"
}
