# checkov:skip=CKV2_AWS_11: VPC Flow Logs not required for this dev/test deployment.
resource "aws_vpc" "mainvpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags                 = { Name = var.vpc_name }
}

resource "aws_subnet" "az1" {
# checkov:skip=CKV_AWS_130: Public subnets needed; instances require internet without NAT
  availability_zone       = var.availability_zones[0]
  cidr_block              = var.public_subnet_cidrs[0]
  vpc_id                  = aws_vpc.mainvpc.id
  map_public_ip_on_launch = true
  tags                    = { Name = "public-subnet-az1" }
}

resource "aws_subnet" "az2" {
# checkov:skip=CKV_AWS_130: Public subnets needed; instances require internet without NAT
  availability_zone       = var.availability_zones[1]
  cidr_block              = var.public_subnet_cidrs[1]
  vpc_id                  = aws_vpc.mainvpc.id
  map_public_ip_on_launch = true
  tags                    = { Name = "public-subnet-az2" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mainvpc.id
  tags   = { Name = "internet-gateway" }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.mainvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "main-route-table" }
}

resource "aws_route_table_association" "route_table_az1" {
  subnet_id      = aws_subnet.az1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "route_table_az2" {
  subnet_id      = aws_subnet.az2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_default_security_group" "default" {
# checkov:skip=CKV2_AWS_12: ASG not required for this dev/test deployment.
  vpc_id = aws_vpc.mainvpc.id
  revoke_rules_on_delete = true
    tags = merge(var.tags, { Name = "default_sg" })
  }