
resource "null_resource" "git_submodule_init" {
  provisioner "local-exec" {
    command     = "git submodule add https://github.com/argoproj/argo-helm && cd argo-helm && git checkout tags/$TAG"
    environment = {
      TAG = var.tag
    }
    interpreter = ["bash", "-c"]
  }
  
  triggers = {
    when_new_release = "${var.tag}-${tostring(var.app.force_update)}"
  }
}

module "helm_release_argocd" {
  source = "git@github.com:terraform-module/terraform-helm-release.git?ref=v2.8.0"

  namespace         = var.namespace
  repository        = var.repository
  app               = var.argocd.app
  values            = var.argocd.values
  repository_config = var.repository_config
  set               = var.set
  set_sensitive     = var.set_sensitive

  depends_on = [
    resource.null_resource.git_submodule_init
  ]
}

module "helm_release_argocd_apps" {
  source = "git@github.com:terraform-module/terraform-helm-release.git?ref=v2.8.0"

  namespace         = var.namespace
  repository        = var.repository
  app               = var.argocd_apps.app
  values            = var.argocd_apps.values
  repository_config = var.repository_config
  set               = var.set
  set_sensitive     = var.set_sensitive

  depends_on = [
    resource.null_resource.git_submodule_init,
    module.helm_release_argocd
  ]
}

# resource "null_resource" "git_submodule_delete" {
#   depends_on = [
#     module.helm_release_argocd,
#     module.helm_release_argocd_apps
#   ]
# }