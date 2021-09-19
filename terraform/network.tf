# VPC
resource "aws_vpc" "main" {
  cidr_block           = local.cidr_block.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}

# Subnet
resource "aws_subnet" "public" {
  for_each = local.cidr_block.public

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${local.name}-public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = local.cidr_block.private

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${local.name}-private-${each.key}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.tags
}

# Route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "${local.name}-public"
  }
}

resource "aws_route_table_association" "public" {
  gateway_id     = aws_internet_gateway.main.id
  route_table_id = aws_route_table.public.id
}