# ### Common vars
variable "env" {}
variable "app_name" {}
variable "alb_servers_asg_id" {}
variable "alb_vpc_id" {}
variable "alb_sg_id" {}
variable "alb_subnet_ids" { type = "list" }
