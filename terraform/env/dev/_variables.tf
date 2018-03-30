# Global-level vars to be passed in
variable "region" {}
variable "ssh_key_name" {}
variable "amis" { type = "map" }

# Environment-level vars
variable "env" { default = "dev" }

variable "vpc_cidr" {
  default     = "172.16.0.0/16"
  description = "CIDR for the dev VPC"
}
