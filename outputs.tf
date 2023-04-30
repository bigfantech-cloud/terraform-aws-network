#----
# VPC 
#----

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "The primary IPv4 CIDR block of the VPC"
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "IGW ID"
}

#-----
# SUBNET 
#-----

output "public_subnet_ids" {
  description = "List of the created public subnets IDs"
  value = [
    for id in aws_subnet.public : id.id
  ]
}

output "private_subnet_ids" {
  description = "List of the created private subnets IDs"
  value = [
    for id in aws_subnet.private : id.id
  ]
}

output "eip_id" {
  value       = aws_eip.public.*.id
  description = "EIP ID"
}

output "ngw_id" {
  value       = aws_nat_gateway.public.*.id
  description = "NAT Gateway ID"
}

output "public_route_table_id" {
  description = "Public subnet associated Route Table ID"
  value       = length(local.public_subnets_az_cidr_map) > 0 ? aws_route_table.public[0].id : null
}

output "public_route_table_arn" {
  description = "Public subnet associated Route Table ARN"
  value       = length(local.public_subnets_az_cidr_map) > 0 ? aws_route_table.public[0].arn : null
}

output "private_route_table_id" {
  description = "Private subnet associated Route Table ID"
  value       = aws_route_table.private.id
}

output "private_route_table_arn" {
  description = "Private subnet associated Route Table ARN"
  value       = aws_route_table.private.arn
}
