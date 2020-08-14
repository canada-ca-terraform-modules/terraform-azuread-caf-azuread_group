data azuread_users group_owners {
  user_principal_names = var.owners
}

resource azuread_group group {
  name                    = local.name
  owners                  = data.azuread_users.group_owners.object_ids
  prevent_duplicate_names = var.prevent_duplicate_names
}
