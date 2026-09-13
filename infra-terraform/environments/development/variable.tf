variable "subnets" {
  description = "Subnets to create"
  type = map(object({
    subnet_name      = string
    address_prefixes = list(string)
  }))
}

variable "aks_subnet" {
  type        = string
  description = "Key of the subnet (from var.subnets) for the AKS node pool and NAT gateway"
  default     = "subnet_1"
}

variable "appgw_subnet" {
  type        = string
  description = "Key of the subnet (from var.subnets) to associate with the application gateway"
  default     = "subnet_2"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
  default     = ["10.10.0.0/16"]
}

variable "acr_sku" {
  type        = string
  description = "SKU for the Azure Container Registry (Basic, Standard, Premium)"
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.acr_sku)
    error_message = "ACR SKU must be one of: Basic, Standard, Premium."
  }
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the AKS default node pool"
  default     = 1
}

variable "aks_vm_size" {
  type        = string
  description = "VM size for the AKS default node pool"
  default     = "Standard_B2s"
}

variable "pod_cidr" {
  type        = string
  description = "CIDR block for pod IP addresses"
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = "CIDR block for Kubernetes service IPs"
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the service CIDR for the DNS service"
  default     = "10.0.0.10"
}
