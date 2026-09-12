variable "subnets" {
  description = "Subnets to create"
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
  }))
}
