module "sshKeys" {
  source              = "./ssh-keys"
  ssh_key_name        = "${var.ssh_key_name}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
}

module "codedeploy" {
  source   = "../../modules/codedeploy"
  region   = "${var.region}"
  app_name = "${var.deployment_app_name}"
}

module "iam" {
  source                = "../../modules/iam"
  codedeploy_policy_arn = "${module.codedeploy.codedeploy_policy_arn}"
}
