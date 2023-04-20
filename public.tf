resource "aws_subnet" "public" {
  for_each = local.public_subnets_az_cidr_map

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value

  tags = merge(
    var.additional_private_subnet_tags,
    module.this.tags,
    {
      "Name" = "${module.this.id}-public-${each.key}"
      "Type" = "public"
    },
  )
}

resource "aws_route_table" "public" {
  count = length(local.public_subnets_az_cidr_map) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(
    var.additional_private_subnet_tags,
    module.this.tags,
    {
      "Name" = "${module.this.id}-public"
      "Type" = "public"
    },
  )
}

resource "aws_route" "public" {
  count = length(local.public_subnets_az_cidr_map) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.public]
}

resource "aws_route_table_association" "public" {
  for_each = local.public_subnets_az_cidr_map

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[0].id
  depends_on = [
    aws_subnet.public,
    aws_route_table.public,
  ]
}

resource "aws_eip" "public" {
  count = local.create_nat_gateway

  vpc = true
  tags = merge(
    module.this.tags,
    {
      "Name" = "${module.this.id}-nat-eip"
      "Type" = "public"
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "public" {
  count = local.create_nat_gateway

  allocation_id = aws_eip.public[0].id
  subnet_id     = local.public_subnet_ids[0]
  depends_on    = [aws_eip.public]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    module.this.tags,
    {
      "Name" = "${module.this.id}-public"
      "Type" = "public"
    },
  )
}
