# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

output name {
  value       = aws_vpc.myvpc.cidr_block
}
