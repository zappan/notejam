
variable "region" {
  default = "us-east-1"
}

# Ubuntu AMIs as of 2018-03-31
variable "amis" {
  default = {
    us-east-1 = "ami-43a15f3e"
  }
}

variable "ssh_key_name" {
  default = "TomislavCapanRSAKey"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
