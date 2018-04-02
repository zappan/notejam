## Variables declaration for *.tfvars
variable "packer_webserver_ami" {}

## Variables defaults
variable "region" {
  default = "us-east-1"
}

variable "ssh_key_name" {
  default = "TomislavCapanRSAKey"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

## Locals - with variables interpolations
locals {
  # Ubuntu AMIs as of 2018-03-31
  default_amis = {
    us-east-1 = "ami-43a15f3e"
  }
  webserver_amis = {
    us-east-1 = "${var.packer_webserver_ami}"
  }
}
