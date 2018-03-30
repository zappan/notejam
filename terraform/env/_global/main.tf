module "sshKeys" {
  source              = "./ssh-keys"
  ssh_key_name        = "${var.ssh_key_name}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
}
