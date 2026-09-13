terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "bootstrap-resource-rg"
    storage_account_name = "bootstrapresourcestrg"
    container_name       = "bootstrap-resource-tfstate"
    key                  = "axion.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
