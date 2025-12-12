env            = "test"
cidr           = "10.2.0.0/16"
private_subnet = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
public_subnet  = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]
nat-gateway = true
single-nat = true
nat-per-az = false
