# ### Common vars
variable "env" {}
variable "region" {}
variable "ssh_key_name" {}
variable "webserver_sg_id" {}
variable "amis" { type = "map" }

variable "instance_type" {
  default = "t2.micro"
}
