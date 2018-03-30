terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
  # backend "s3" {
  #   bucket  = "toptal.devops"
  #   key     = "terraform.tfstate"
  #   region  = "us-east-1"
  #   profile = "toptaldevopsadmin"
  # }
}

provider "aws" {
  region  = "${var.region}"
  profile = "toptaldevopsadmin"
}
