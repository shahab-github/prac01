terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.63.0"
    }
  }
  
  backend "azurerm" {
   resource_group_name = "dev"
   storage_account_name = "kodesa"
   container_name = "tfstate"
   key = "terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
}
