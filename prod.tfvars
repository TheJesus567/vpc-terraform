env            = "prod"
cidr           = "10.1.0.0/16"
private_subnet = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
public_subnet  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
nat-gateway = true
single-nat = false
nat-per-az = true
