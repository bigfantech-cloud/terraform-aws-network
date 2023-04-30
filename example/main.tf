provider "aws" {
  region = "us-east-1"
}

module "network" {
  source  = "bigfantech-cloud/network/aws"
  version = "a.b.c" # find latest version from https://registry.terraform.io/modules/bigfantech-cloud/network/aws/latest

  project_name = "abc"
  environment  = "dev"
  cidr_block   = "10.0.0.0/16"
}
