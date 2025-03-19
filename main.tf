provider "azurerm" {
  features {}

  subscription_id = "92c6c6b9-38e4-45d2-b008-67d96607f54b"
}

resource "azurerm_resource_group" "rg" {
  name     = "k8s-terraform"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "k8s-terraform-cluster"
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
