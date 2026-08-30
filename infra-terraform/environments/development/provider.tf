terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.3.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "bootstrap-resource-rg"      # Can also be set via `ARM_ACCESS_KEY` environment variable.
    storage_account_name = "bootstrapresourcestrg"      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "bootstrap-resource-tfstate" # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "axion.terraform.tfstate"    # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {}
}
