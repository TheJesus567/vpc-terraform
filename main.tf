# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr

  tags = {
    Name      = "myvpc"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public-subnets" {
  for_each          = var.public_subnet
  cidr_block        = cidrsubnet(var.cidr, 8, each.value + 1)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  vpc_id            = aws_vpc.myvpc.id

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private-subnets" {
  for_each          = var.private_subnet
  cidr_block        = cidrsubnet(var.cidr, 8, each.value + 4)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  vpc_id            = aws_vpc.myvpc.id

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name      = "my-internet-gateway"
    ManagedBy = "Terraform"
  }
}

resource "aws_eip" "public-ip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.internet-gw]
  tags = {
    Name = "my-public-ip"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.public-ip.id
  subnet_id     = aws_subnet.public-subnets["public-subnet-1"].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet-gw]
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name = "public-route-table"
  }

}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public-rt-association" {
  for_each       = var.public_subnet
  subnet_id      = aws_subnet.public-subnets[each.key].id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-rt-association" {
  for_each       = var.private_subnet
  subnet_id      = aws_subnet.private-subnets[each.key].id
  route_table_id = aws_route_table.private-route-table.id
}