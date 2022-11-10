
resource "null_resource" "git_submodule_init" {
  provisioner "local-exec" {
    command     = "git submodule add https://github.com/argoproj/argo-helm --branch $TAG"
    environment = {
      TAG = var.tag
    }
    interpreter = ["bash", "-c"]
  }
  
  triggers = {
    always_run = "${timestamp()}"
  }
}

module "helm_release_argocd" {
  source = "git@github.com:terraform-module/terraform-helm-release.git?ref=v2.8.0"

  namespace         = var.namespace
  app               = var.app
  repository        = var.repository
  repository_config = var.repository_config
  values            = var.values
  set               = var.set
  set_sensitive     = var.set_sensitive

  depends_on = [
    resource.null_resource.git_submodule_init
  ]
}

# module "helm_release_argocd_apps" {
#   depends_on = [
#     module.helm_release_argocd
#   ]
# }