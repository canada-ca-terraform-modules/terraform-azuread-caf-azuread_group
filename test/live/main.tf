terraform {
  required_version = ">= 1.9"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }

  # Empty on purpose: the state file path is supplied at `terraform init`
  # time via `-backend-config="path=..."` (partial configuration), so a
  # baseline checkout and a PR/candidate checkout can point at the same
  # external state file without either owning its own local state.
  backend "local" {}
}

provider "azuread" {}

module "azuread_group" {
  # Baseline and candidate code are two on-disk checkouts of this same repo,
  # not two resolved git refs - no pinned ?ref, no version toggle here.
  source = "../../"

  env               = var.env
  userDefinedString = var.userDefinedString
  owners            = var.owners
}
