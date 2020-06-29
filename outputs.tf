output "azuread_groups" {
  description = "Returns the full set of azuread_group created"

  value = azuread_group.groups
}