variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate with the NAT gateway"
}

variable "nat_gateway_id" {
  type        = string
  description = "The ID of the NAT gateway to associate with the subnet"
}
