provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.11.0"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "helm_release" "dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "6.0.5"

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = "dashboard.example.com"
  }

  set {
    name  = "ingress.hosts[0].paths[0]"
    value = "/"
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "13.2.29"

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = "30080"
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = "30443"
  }
}