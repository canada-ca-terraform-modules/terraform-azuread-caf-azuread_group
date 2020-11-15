output "object" {
  description = "Returns the full set of azuread_group created"

  value = azuread_group.group
}

output "name" {
  description = "Returns the display name for the Group."

  value = azuread_group.group.name
}

output "owners" {
  description = "Returns a set of owners who own this Group."

  value = azuread_group.group.owners
}

output "id" {
  description = "Return the Object ID of the Group."

  value = azuread_group.group.id
}