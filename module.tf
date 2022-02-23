
resource "azuread_group" "groups" {
  for_each = var.azuread_groupsMap

  display_name            = local.names[each.value.userDefinedString]
  owners                  = data.azuread_users.group_owners[each.key].object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
  mail_enabled            = var.mail_enabled
  security_enabled        = var.security_enabled
  description             = var.description
  assignable_to_role      = var.assignable_to_role
  behaviors               = var.behaviors
  mail_nickname           = var.mail_nickname
  types                   = var.types
}

data "azuread_users" "group_owners" {
  for_each = var.azuread_groupsMap

  user_principal_names = each.value.owners
}
