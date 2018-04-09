# ### Common vars
variable "env" {}
variable "region" {}
variable "ssh_key_name" {}
variable "webserver_sg_id" {}
variable "amis" { type = "map" }

variable "instance_type" {
  default = "t2.micro"
}

# ASG vars
variable "asg_min" {}
variable "asg_max" {}
variable "asg_desired" {}
variable "webserver_subnet_ids" { type = "list" }
variable "webserver_iam_profile" {}

# EFS
variable "efs_sg_id" {}

# Deployment vars
variable "deployment_app_name" {}
variable "deployment_config_name" { default = "CodeDeployDefault.AllAtOnce" }
variable "deployment_type" { default = "IN_PLACE"}    # IN_PLACE or BLUE_GREEN
variable "deployment_option" {}                       # WITH_TRAFFIC_CONTROL or WITHOUT_TRAFFIC_CONTROL
variable "deployment_service_role_arn" {}

# ### External services
variable "datadog_api_key" {}
