output "kubernetes_cluster_ids" {
  description = "Key outputs from the AKS resource"
  value = {
    id                  = azurerm_kubernetes_cluster.aks_cluster.id
    name                = azurerm_kubernetes_cluster.aks_cluster.name
    kubelet_object_id   = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
    oidc_issuer_url     = azurerm_kubernetes_cluster.aks_cluster.oidc_issuer_url
    node_resource_group = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
  }
}
