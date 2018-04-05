# Global-level vars to be passed in
variable "region" {}
variable "ssh_key_name" {}
variable "default_amis" { type = "map" }
variable "webserver_amis" { type = "map" }

# Environment-level vars
variable "env" { default = "prod" }

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR for the production VPC"
}

variable "webserver_iam_profile" {}

variable "bastion_asg_min" { default = 0 }
variable "bastion_asg_max" { default = 0 }
variable "bastion_asg_desired" { default = 0 }

variable "webserver_asg_min" { default = 0 }
variable "webserver_asg_max" { default = 0 }
variable "webserver_asg_desired" { default = 0 }

# Deployment vars
variable "deployment_app_name" {}
variable "deployment_option" {}
variable "codedeploy_role_arn" {}

# ### External services
variable "datadog_api_key" {}
