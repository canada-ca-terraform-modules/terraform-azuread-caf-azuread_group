
resource azuread_group groups {
  for_each = var.azuread_groupsMap

  name   = local.names[each.value.userDefinedString]
  owners = data.azuread_users.group_owners[each.key].object_ids
}

data azuread_users group_owners {
  for_each = var.azuread_groupsMap

  user_principal_names = each.value.owners
}