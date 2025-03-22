output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive = true
}

output "resource_group_name" {
  value = data.azurerm_resource_group.rg.id
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}
