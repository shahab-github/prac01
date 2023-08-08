# configure the backend in the azure
terraform {
    backend "azurerm" {
        resource_group_name = "tfstate"  # make sure you have this resource group
        storage_account_name = "tfstate7786" # make sure you have this storage account already
        container_name = "tfstate-dev"
        key = "terraform.tfstate"
    }
}