provider "aws" {
  region = "us-east-1"
}

module "network" {
  source  = "bigfantech-cloud/network/aws"
  version = "1.0.0"

  project_name = "abc"
  environment  = "dev"
  cidr_block   = "10.0.0.0/16"
}
