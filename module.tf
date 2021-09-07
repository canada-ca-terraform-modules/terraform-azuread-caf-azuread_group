data "azuread_users" "group_owners" {
  user_principal_names = var.owners
}

resource "azuread_group" "group" {
  display_name            = local.name
  owners                  = data.azuread_users.group_owners.object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
  mail_enabled            = var.mail_enabled
  security_enabled        = var.security_enabled
  description             = var.description
  assignable_to_role      = var.assignable_to_role
  behaviors               = var.behaviors
  mail_nickname           = var.mail_nickname
  types                   = var.types
}
