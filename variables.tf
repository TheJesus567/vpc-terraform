variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC. Defines the range of private IP addresses available for resources within the VPC"
}

variable "public_subnet_cidr" {
  type = map(any)
  default = {
    public-subnet-1 : "0"
    public-subnet-2 : "1"
    public-subnet-3 : "2"
  }
}

variable "private_subnet_cidr" {
  type = map(any)
  default = {
    private-subnet-1 : "0"
    private-subnet-2 : "1"
    private-subnet-3 : "2"
  }
}