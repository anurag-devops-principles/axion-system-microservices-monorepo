locals {
  environment = "dev"
  application = "axion-system"
  region      = "eastus"
  managed_by  = "terraform"
  name_prefix = "${local.environment}-${local.application}"

  common_tags = {
    "environment" = local.environment
    "application" = local.application
    "managed-by"  = local.managed_by
  }
}

