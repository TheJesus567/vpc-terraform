module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc-${var.env}"
  cidr = var.cidr

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = var.private_subnet
  public_subnets  = var.public_subnet

  default_security_group_egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]


  enable_nat_gateway     = var.nat-gateway
  single_nat_gateway     = var.single-nat
  one_nat_gateway_per_az = var.nat-per-az

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
