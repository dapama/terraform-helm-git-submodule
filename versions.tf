terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "5.8.0"
    }
  }
}

provider "github" {}