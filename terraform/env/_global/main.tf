module "sshKeys" {
  source              = "./ssh-keys"
  ssh_key_name        = "${var.ssh_key_name}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
}

module "storage" {
  source = "../../modules/storage"
}

module "codedeploy" {
  source   = "../../modules/codedeploy"
  region   = "${var.region}"
  app_name = "${var.deployment_app_name}"
}

module "iam_webserver" {
  source            = "../../modules/iam.webserver"
  codedeploy_bucket = "${module.codedeploy.codedeploy_bucket}"
  app_backup_bucket = "${module.storage.notejam_backup_bucket}"
}
