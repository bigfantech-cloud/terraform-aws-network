data "aws_availability_zones" "az" {
  state = "available"
}

locals {

  availability_zones = data.aws_availability_zones.az.names
  public_cidr_block  = cidrsubnet(var.cidr_block, 1, 0)
  private_cidr_block = cidrsubnet(var.cidr_block, 1, 1)

  azs_to_public_subnets_cidr_map  = { for k, az in local.availability_zones : az => cidrsubnet(local.public_cidr_block, 3, k) }
  azs_to_private_subnets_cidr_map = { for k, az in local.availability_zones : az => cidrsubnet(local.private_cidr_block, 3, k) }

  custom_azs_to_public_subnets_cidr_map  = var.public_subnets_cidr != null && var.public_subnets_cidr != [] ? { for k, az in local.availability_zones : az => var.public_subnets_cidr[k] } : {}
  custom_azs_to_private_subnets_cidr_map = length(var.private_subnets_cidr) > 0 ? { for k, az in local.availability_zones : az => var.private_subnets_cidr[k] } : {}

  public_subnets_az_cidr_map  = var.public_subnets_cidr == null ? local.azs_to_public_subnets_cidr_map : local.custom_azs_to_public_subnets_cidr_map
  private_subnets_az_cidr_map = length(var.private_subnets_cidr) == 0 ? local.azs_to_private_subnets_cidr_map : local.custom_azs_to_private_subnets_cidr_map

  create_nat_gateway = length(local.public_subnets_az_cidr_map) > 0 && var.nat_gateway_enabled ? 1 : 0

  # OUTPUTS

  public_subnet_ids  = [for id in aws_subnet.public : id.id]
  private_subnet_ids = [for id in aws_subnet.private : id.id]
}
