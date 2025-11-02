variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC. Defines the range of private IP addresses available for resources within the VPC"
}

variable "public_subnet" {
  type = list 
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
}

variable "private_subnet" {
  type = list
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] 
}
