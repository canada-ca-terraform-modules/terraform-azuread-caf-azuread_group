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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_group.group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_users.group_owners](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assignable_to_role"></a> [assignable\_to\_role](#input\_assignable\_to\_role) | Indicates whether this group can be assigned to an Azure Active Directory role. Can only be true for security-enabled groups. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_behaviors"></a> [behaviors](#input\_behaviors) | A set of behaviors for a Microsoft 365 group. Possible values are AllowOnlyMembersToPost, HideGroupInOutlook, SubscribeNewGroupMembers and WelcomeEmailDisabled. See official documentation for more details. Changing this forces a new resource to be created. | `any` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description for the group. | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | 4 chars defining the environment name prefix for the VM. Example: ScSc | `string` | n/a | yes |
| <a name="input_mail_enabled"></a> [mail\_enabled](#input\_mail\_enabled) | Whether the group is a mail enabled, with a shared group mailbox. At least one of mail\_enabled or security\_enabled must be specified. Only Microsoft 365 groups can be mail enabled (see the types property). | `bool` | `false` | no |
| <a name="input_mail_nickname"></a> [mail\_nickname](#input\_mail\_nickname) | The mail alias for the group, unique in the organisation. Required for mail-enabled groups. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_maxLength"></a> [maxLength](#input\_maxLength) | Maximum length of CAF compliant name | `number` | `80` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | A set of owners who own this Group. Supported Object types are Users or Service Principals. | `any` | n/a | yes |
| <a name="input_prevent_duplicate_names"></a> [prevent\_duplicate\_names](#input\_prevent\_duplicate\_names) | If true, will return an error when an existing Group is found with the same name. | `bool` | `true` | no |
| <a name="input_security_enabled"></a> [security\_enabled](#input\_security\_enabled) | Whether the group is a mail enabled, with a shared group mailbox. At least one of mail\_enabled or security\_enabled must be specified. Only Microsoft 365 groups can be mail enabled (see the types property). | `bool` | `true` | no |
| <a name="input_types"></a> [types](#input\_types) | A set of group types to configure for the group. The only supported type is Unified, which specifies a Microsoft 365 group. Required when mail\_enabled is true. Changing this forces a new resource to be created. | `any` | `[]` | no |
| <a name="input_userDefinedString"></a> [userDefinedString](#input\_userDefinedString) | User defined portion of the server name. Up to 8 chars minus the postfix lenght | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Return the Object ID of the Group. |
| <a name="output_object"></a> [object](#output\_object) | Returns the full set of azuread\_group created |
| <a name="output_owners"></a> [owners](#output\_owners) | Returns a set of owners who own this Group. |
<!-- END_TF_DOCS -->