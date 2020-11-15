# Deploys Azure Active Directory Groups

Creates an Azure VNET.

Reference the module to a specific version (recommended):

```hcl
locals {
  azuread_groupsMap = {
    L1_Subscription_Owners = {
      userDefinedString = "${var.group}_${var.project}_L1_Subscription_Owners"
      owners            = var.L1_RBAC.ownerNames
    },
    L1_Subscription_Contributors = {
      userDefinedString = "${var.group}_${var.project}_L1_Subscription_Contributors"
      owners            = var.L1_RBAC.ownerNames
    },
  }
}

module azuread_groups_L1 {
  source = "github.com/canada-ca-terraform-modules/terraform-azuread-caf-azuread_group?ref=v1.1.0"
  for_each = local.azuread_groupsMap

  env    = var.env
  userDefinedString = each.value.userDefinedString
  owners = each.value.owners
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | 4 chars defining the environment name prefix for the VM. Example: ScSc | `string` | n/a | yes |
| owners | A set of owners who own this Group. Supported Object types are Users or Service Principals. | `any` | n/a | yes |
| userDefinedString | User defined portion of the server name. Up to 8 chars minus the postfix lenght | `string` | n/a | yes |
| maxLength | Maximum length of CAF compliant name | `number` | `80` | no |
| prevent\_duplicate\_names | If true, will return an error when an existing Group is found with the same name. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Return the Object ID of the Group. |
| name | Returns the display name for the Group. |
| object | Returns the full set of azuread\_group created |
| owners | Returns a set of owners who own this Group. |

