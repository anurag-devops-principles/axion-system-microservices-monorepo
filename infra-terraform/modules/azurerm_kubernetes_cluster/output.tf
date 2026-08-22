output "kubernetes_cluster" {
  description = "The created AKS cluster."
  value = {
    id                  = azurerm_kubernetes_cluster.kubernetes_cluster.id
    name                = azurerm_kubernetes_cluster.kubernetes_cluster.name
    kubelet_object_id   = azurerm_kubernetes_cluster.kubernetes_cluster.kubelet_identity[0].object_id
    oidc_issuer_url     = azurerm_kubernetes_cluster.kubernetes_cluster.oidc_issuer_url
    node_resource_group = azurerm_kubernetes_cluster.kubernetes_cluster.node_resource_group
  }
}
