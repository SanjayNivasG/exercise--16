resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
  depends_on = [module.eks]
}

resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }
  depends_on = [module.eks]
}
