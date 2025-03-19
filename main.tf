provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create Storage Account for remote Backend
resource "azurerm_storage_account" "terraform" {
  name                     = "terraformstateacc"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Storage Container to store Statefile
resource "azurerm_storage_container" "terraform" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.terraform.name
  container_access_type = "private"
}

# Remote Backend config
terraform {
  backend "azurerm" {
    resource_group_name  = "k8s-terraform"
    storage_account_name = "terraformstateacc"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
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
