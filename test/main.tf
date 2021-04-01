terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 1.4.0"
    }
  }
  required_version = ">= 0.13"
}

provider "azuread" {
#   version = ">= 0.11.0"
}

locals {
  template_name = "azuread_group"
  azuread_groupsMap = {
    L1_Subscription_Owners = {
      userDefinedString = "${local.template_name}_L1_Subscription_Owners"
      owners            = ["bernard.maltais@ssc-spc.gc.ca"]
    },
    L1_Subscription_Contributors = {
      userDefinedString = "${local.template_name}_L1_Subscription_Contributors"
      owners            = ["bernard.maltais@ssc-spc.gc.ca"]
    },
  }
}

module azuread_groups_L1 {
  source   = "../."
  for_each = local.azuread_groupsMap

  env               = "ScTc"
  userDefinedString = each.value.userDefinedString
  owners            = each.value.owners
}