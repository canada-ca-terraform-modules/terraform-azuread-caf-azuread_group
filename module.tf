data "azuread_users" "group_owners" {
  user_principal_names = var.owners
}

resource "azuread_group" "group" {
  display_name               = var.name != null ? var.name : local.name
  owners                     = data.azuread_users.group_owners.object_ids
  prevent_duplicate_names    = var.prevent_duplicate_names
  mail_enabled               = var.mail_enabled
  security_enabled           = var.security_enabled
  description                = var.description
  assignable_to_role         = var.assignable_to_role
  behaviors                  = var.behaviors
  mail_nickname              = var.mail_nickname
  types                      = var.types
  administrative_unit_ids    = var.administrative_unit_ids
  auto_subscribe_new_members = var.auto_subscribe_new_members
  external_senders_allowed   = var.external_senders_allowed
  hide_from_address_lists    = var.hide_from_address_lists
  hide_from_outlook_clients  = var.hide_from_outlook_clients
  members                    = var.members
  onpremises_group_type      = var.onpremises_group_type
  provisioning_options       = var.provisioning_options
  theme                      = var.theme
  visibility                 = var.visibility
  writeback_enabled          = var.writeback_enabled

  dynamic "dynamic_membership" {
    for_each = var.dynamic_membership != null ? [var.dynamic_membership] : []
    content {
      enabled = dynamic_membership.value.enabled
      rule    = dynamic_membership.value.rule
    }
  }

  lifecycle {
    ignore_changes = [
      administrative_unit_ids,
      owners
    ]
  }
}
