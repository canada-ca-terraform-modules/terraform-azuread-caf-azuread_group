mock_provider "azuread" {}

variables {
  env               = "Dev"
  userDefinedString = "grp01"
  owners            = ["owner@example.com"]
}

run "naming_convention" {
  command = plan

  assert {
    condition     = azuread_group.group.display_name == "Dev-grp01"
    error_message = "Name must follow {env4}-{userDefinedString} convention"
  }
}

run "default_values" {
  command = plan

  assert {
    condition     = azuread_group.group.prevent_duplicate_names == true
    error_message = "prevent_duplicate_names must default to true"
  }

  assert {
    condition     = azuread_group.group.mail_enabled == false
    error_message = "mail_enabled must default to false"
  }

  assert {
    condition     = azuread_group.group.security_enabled == true
    error_message = "security_enabled must default to true"
  }

  assert {
    condition     = azuread_group.group.assignable_to_role == false
    error_message = "assignable_to_role must default to false"
  }

  assert {
    condition     = azuread_group.group.description == ""
    error_message = "description must default to empty string"
  }

  assert {
    condition     = length(azuread_group.group.dynamic_membership) == 0
    error_message = "dynamic_membership must not be rendered when not supplied"
  }
}

run "custom_name_override" {
  command = plan

  variables {
    name = "existing-prod-group"
  }

  assert {
    condition     = azuread_group.group.display_name == "existing-prod-group"
    error_message = "name override must take priority over the generated display_name"
  }
}

run "dynamic_membership_group" {
  command = plan

  variables {
    types = ["DynamicMembership"]
    dynamic_membership = {
      enabled = true
      rule    = "user.department -eq \"Sales\""
    }
  }

  assert {
    condition     = length(azuread_group.group.dynamic_membership) == 1
    error_message = "dynamic_membership block must be rendered when supplied"
  }

  assert {
    condition     = tolist(azuread_group.group.dynamic_membership)[0].enabled == true
    error_message = "dynamic_membership.enabled must be passed through"
  }

  assert {
    condition     = tolist(azuread_group.group.dynamic_membership)[0].rule == "user.department -eq \"Sales\""
    error_message = "dynamic_membership.rule must be passed through"
  }
}

run "members_supplied" {
  command = apply

  variables {
    members = ["00000000-0000-0000-0000-000000000001"]
  }

  assert {
    condition     = azuread_group.group.members != null
    error_message = "members must be passed through when supplied"
  }
}

run "m365_group_optional_args" {
  command = plan

  variables {
    mail_enabled               = true
    mail_nickname              = "ExampleGroup"
    types                      = ["Unified"]
    auto_subscribe_new_members = true
    external_senders_allowed   = false
    hide_from_address_lists    = true
    hide_from_outlook_clients  = false
    theme                      = "Blue"
    visibility                 = "Private"
    provisioning_options       = ["Team"]
  }

  assert {
    condition     = azuread_group.group.auto_subscribe_new_members == true
    error_message = "auto_subscribe_new_members must be passed through"
  }

  assert {
    condition     = azuread_group.group.theme == "Blue"
    error_message = "theme must be passed through"
  }

  assert {
    condition     = azuread_group.group.visibility == "Private"
    error_message = "visibility must be passed through"
  }
}

run "writeback_onpremises" {
  command = plan

  variables {
    writeback_enabled     = true
    onpremises_group_type = "UniversalSecurityGroup"
  }

  assert {
    condition     = azuread_group.group.writeback_enabled == true
    error_message = "writeback_enabled must be passed through"
  }

  assert {
    condition     = azuread_group.group.onpremises_group_type == "UniversalSecurityGroup"
    error_message = "onpremises_group_type must be passed through"
  }
}

# administrative_unit_ids is listed in the resource's lifecycle.ignore_changes
# (pre-existing, not introduced by this upgrade), so mock_provider always
# resolves it to null regardless of the supplied value on both plan and
# apply. Coverage is limited to confirming the variable is wired to the
# resource without a plan/apply error (see naming_convention / default_values).
run "administrative_unit_ids_no_error" {
  command = plan

  variables {
    administrative_unit_ids = ["00000000-0000-0000-0000-000000000002"]
  }

  assert {
    condition     = azuread_group.group.display_name == "Dev-grp01"
    error_message = "Supplying administrative_unit_ids must not affect display_name or error the plan"
  }
}
