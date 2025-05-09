# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "public-subnets" {
  for_each          = var.public_subnet_cidr
  cidr_block        = cidrsubnet(var.cidr, 8, each.value +1)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  vpc_id            = aws_vpc.myvpc.id

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private-subnets" {
  for_each = var.private_subnet_cidr
  cidr_block        = cidrsubnet(var.cidr, 8, each.value + 4)
  availability_zone = data.aws_availability_zones.available.names[each.value]
  vpc_id            = aws_vpc.myvpc.id

  tags = {
    Name = each.key
  }
}

output "az" {
  value = data.aws_availability_zones.available.names
}