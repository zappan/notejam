# ### Common vars
variable "env" {}
variable "region" {}
variable "ssh_key_name" {}
variable "bastion_sg_id" {}
variable "amis" { type = "map" }

variable "instance_type" {
  default = "t2.nano"
}

# ### ASG vars
variable "asg_min" {}
variable "asg_max" {}
variable "asg_desired" {}
variable "asg_subnet_ids" { type = "list" }

# ### External services
variable "datadog_api_key" {}
