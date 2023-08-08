resource "helm_release" "argo_workflows" {
  name       = "argo-workflows"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"
  namespace  = "argo"
  version    = "0.32.1"

  set {
    name  = "server.extraArgs"
    value = "{--auth-mode=server}" # So that we can log in to the UI without authentication
  }
}