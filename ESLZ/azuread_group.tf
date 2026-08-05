# ESLZ/azuread_group.tf
# Declares the variables consumed by the module block so callers can wire
# their own var.* values in, and the module block itself.

terraform {
  required_version = ">= 1.9"
}

variable "azuread_group" {
  description = "Map of azuread_group configuration objects"
  type        = any
  default     = {}
}

module "azuread_group" {
  source   = "github.com/canada-ca-terraform-modules/terraform-azuread-caf-azuread_group?ref=v1.4.0"
  for_each = var.azuread_group

  env                        = each.value.env
  userDefinedString          = each.value.userDefinedString
  owners                     = each.value.owners
  name                       = try(each.value.name, null)
  maxLength                  = try(each.value.maxLength, 80)
  prevent_duplicate_names    = try(each.value.prevent_duplicate_names, true)
  mail_enabled               = try(each.value.mail_enabled, false)
  mail_nickname              = try(each.value.mail_nickname, null)
  security_enabled           = try(each.value.security_enabled, true)
  description                = try(each.value.description, "")
  assignable_to_role         = try(each.value.assignable_to_role, false)
  behaviors                  = try(each.value.behaviors, [])
  types                      = try(each.value.types, [])
  administrative_unit_ids    = try(each.value.administrative_unit_ids, null)
  auto_subscribe_new_members = try(each.value.auto_subscribe_new_members, null)
  dynamic_membership         = try(each.value.dynamic_membership, null)
  external_senders_allowed   = try(each.value.external_senders_allowed, null)
  hide_from_address_lists    = try(each.value.hide_from_address_lists, null)
  hide_from_outlook_clients  = try(each.value.hide_from_outlook_clients, null)
  members                    = try(each.value.members, null)
  onpremises_group_type      = try(each.value.onpremises_group_type, null)
  provisioning_options       = try(each.value.provisioning_options, null)
  theme                      = try(each.value.theme, null)
  visibility                 = try(each.value.visibility, null)
  writeback_enabled          = try(each.value.writeback_enabled, null)
}
