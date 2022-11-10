
# module "helm_release" {
#   source = "git@github.com:terraform-module/terraform-helm-release.git?ref=v2.8.0"

#   namespace         = var.namespace
#   app               = var.app
#   repository        = var.repository
#   repository_config = var.repository_config
#   values            = var.values
#   set               = var.set
#   set_sensitive     = var.set_sensitive
# }

resource "null_resource" "git_clone" {
  provisioner "local-exec" {
    command     = "cd $PATH && git submodule update --init"
    # command     = "./scripts/git_clone.sh -t 300"
    environment = {
      PATH = var.git_submodule_path
    }
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  # depends_on = [
  #   module.helm_release
  # ]
}
