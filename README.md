# Deploys Azure Active Directory Groups

Creates an Azure VNET.

Reference the module to a specific version (recommended):

```hcl
module azuread_groups_L1 {
  source = "github.com/canada-ca-terraform-modules/terraform-azuread-caf-azuread_group?ref=v1.0.0"
  env    = var.env
  azuread_groupsMap = {
    L1_Subscription_Owners = {
      userDefinedString = "${var.group}_${var.project}_L1_Subscription_Owners"
      owners            = var.L1_RBAC.ownerNames
    },
    L1_Subscription_Contributors = {
      userDefinedString = "${var.group}_${var.project}_L1_Subscription_Contributors"
      owners            = var.L1_RBAC.ownerNames
    },
    L1_Subscription_Readers = {
      userDefinedString = "${var.group}_${var.project}_L1_Subscription_Readers"
      owners            = var.L1_RBAC.ownerNames
    },
    L2_Subscription_Owners = {
      userDefinedString = "${var.group}_${var.project}_L2_Subscription_Owners"
      owners            = var.L1_RBAC.ownerNames
    },
    L2_Subscription_Contributors = {
      userDefinedString = "${var.group}_${var.project}_L2_Subscription_Contributors"
      owners            = var.L1_RBAC.ownerNames
    },
    L2_Subscription_Readers = {
      userDefinedString = "${var.group}_${var.project}_L2_Subscription_Readers"
      owners            = var.L1_RBAC.ownerNames
    },
  }
}

locals {
  azuread_groups_L1 = module.azuread_groups_L1.azuread_groups
}
```

## Inputs

| Name              | Type   | Default | Description                                                                              |
| ----------------- | ------ | ------- | ---------------------------------------------------------------------------------------- |
| azuread_groupsMap | object | None    | (Required) Map of Azure Active Directory Groups config.                                  |
| max_length        | string | None    | (Optional) maximum length to the name of the resource.                                   |
| env               | string | None    | (Required) You can use a prefix to add to the list of resource groups you want to create |

## Output

| Name           | Type   | Description                                                        |
| -------------- | ------ | ------------------------------------------------------------------ |
| azuread_groups | object | Returns the full object containing the created AAD Groups created. |
