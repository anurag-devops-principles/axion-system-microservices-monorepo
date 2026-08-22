locals {
  environment = "dev"
  application = "axion-system"
  region      = "eastus"
}

locals {
  name_prefix = "${local.environment}-${local.application}"
}

locals {
  common_tags = {
    "environment" = local.environment
    "application" = local.application
    "managed-by"  = "terraform"
  }
}
