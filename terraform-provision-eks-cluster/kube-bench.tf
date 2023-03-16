resource "helm_release" "kube_bench" {
  name       = "kube-bench"
  repository = "https://charts.deliveryhero.io/"
  chart      = "kube-bench"
  version    = "0.1.7"
}
