
module "helm_release" {
  source = "git@github.com:terraform-module/terraform-helm-release.git?ref=v2.8.0"

  namespace         = var.namespace
  app               = var.app
  repository        = var.repository
  repository_config = var.repository_config
  values            = var.values
  set               = var.set
  set_sensitive     = var.set_sensitive
}

resource "null_resource" "git_submodule_init" {
  provisioner "local-exec" {
    command     = "cd ../../.. && git submodule update --init"
    interpreter = ["bash", "-c"]
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [
    module.helm_release
  ]
}
