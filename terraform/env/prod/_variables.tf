# Global-level vars to be passed in
variable "region" {}
variable "ssh_key_name" {}
variable "amis" { type = "map" }

# Environment-level vars
variable "env" { default = "prod" }

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR for the production VPC"
}
