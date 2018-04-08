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
  app_name            = "Notejam"
  deployment_app_name = "ToptalDevOpsScreening.${local.app_name}"

  ### LOGGING :: DataDog reg email: toptaldevops@1usemail.com (http://www.1usemail.com/) (123)
  datadog_api_key = "75fccbf84c1ada6945f926bf72091743"

  # Ubuntu AMIs as of 2018-03-31
  default_amis = {
    us-east-1 = "ami-43a15f3e"
  }
  webserver_amis = {
    us-east-1 = "${var.packer_webserver_ami}"
  }
}
