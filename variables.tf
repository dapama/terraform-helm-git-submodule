variable "namespace" {
  description = "namespace where to deploy an application"
  type        = string
}

variable "repository_config" {
  description = "repository configuration"
  type        = map(any)
  default     = {}
}

variable "set" {
  description = "Value block with custom STRING values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  type = list(object({
    path  = string
    value = string
  }))
  default = null
}

variable "repository" {
  description = "Helm repository"
  type        = string
}

variable "tag" {
  description = "Helm repository Tag"
  type        = string
  default     = "latest"
}

variable "argocd" {
  description = "ArgoCD Chart variables"
  type        = map(any)
  default     = {}
}

variable "argocd_apps" {
  description = "ArgoCD_Apps Chart variables"
  type        = map(any)
  default     = {}
}

variable "values_argocd" {
  description = "Extra values for ArgoCD"
  type        = list(string)
  default     = []
}

variable "values_argocd_apps" {
  description = "Extra values for ArgoCD_Apps"
  type        = list(string)
  default     = []
}
