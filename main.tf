provider "azurerm" {
  features {}

  subscription_id = local.config.subscription_id
}

# Remote Backend config
terraform {
  backend "azurerm" {}
}

# Use existing Resource Group
data "azurerm_resource_group" "rg" {
  name = "k8s-terraform"
}


# Use existing Storage Account for remote Backend
data "azurerm_storage_account" "terraform" {
  name                     = local.config.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
}

# Use existing Storage Container to store Statefile
data "azurerm_storage_container" "terraform" {
  name                  = "terraform-state"
  storage_account_name  = data.azurerm_storage_account.terraform.name
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.config.cluster_name
  location           = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix         = "k8s-terraform"

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_B2s"
    node_count = 1
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Free"
}
