subnets = {
  subnet_1 = {
    subnet_name      = "aks-subnet"
    address_prefixes = ["10.10.1.0/24"]
  }
  subnet_2 = {
    subnet_name      = "application-gateway"
    address_prefixes = ["10.10.2.0/24"]
  }
}

subnet-nsg = "subnet_1"
