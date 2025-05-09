variable cidr {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC. Defines the range of private IP addresses available for resources within the VPC"
}
