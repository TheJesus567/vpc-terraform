variable "env" {
  type    = string
  default = "dev"
}

variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC. Defines the range of private IP addresses available for resources within the VPC"
}

variable "public_subnet" {
  type    = list(any)
  default = ["10.0.1.0/24"]
}

variable "private_subnet" {
  type    = list(any)
  default = ["10.0.101.0/24"]
}

variable "nat-gateway" {
  default = false
}

variable "single-nat" {
  default = false
}

variable "nat-per-az" {
  default = false
}
