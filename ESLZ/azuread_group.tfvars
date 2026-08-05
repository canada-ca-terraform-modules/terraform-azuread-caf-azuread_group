# ESLZ/azuread_group.tfvars
# Rules: existing entries unchanged; new args go below, commented out with explanation

azuread_group = {
  # --- EXISTING ENTRY (unchanged) ---
  L1_Subscription_Owners = {
    env               = "Dev"
    userDefinedString = "L1_Subscription_Owners"
    owners            = ["owner1@example.com", "owner2@example.com"]
  }

  # --- NEW ARGUMENT EXAMPLES (commented out) ---
  # example_m365_group = {
  #   env               = "Dev"
  #   userDefinedString = "example"
  #   owners            = ["owner@example.com"]
  #
  #   # name = "" # Optional: Override the auto-generated display_name (default: {env4}-{userDefinedString})
  #
  #   mail_enabled  = true
  #   mail_nickname = "ExampleGroup"
  #   types         = ["Unified"]
  #
  #   # New in azuread >= 3.x
  #   auto_subscribe_new_members = true
  #   external_senders_allowed   = false
  #   hide_from_address_lists    = true
  #   hide_from_outlook_clients  = false
  #   theme                      = "Blue"
  #   visibility                 = "Private"
  #   provisioning_options       = ["Team"]
  #
  #   # Dynamic membership (mutually exclusive with members)
  #   types = ["Unified", "DynamicMembership"]
  #   dynamic_membership = {
  #     enabled = true
  #     rule    = "user.department -eq \"Sales\""
  #   }
  #
  #   # Static membership (mutually exclusive with dynamic_membership)
  #   # members = ["00000000-0000-0000-0000-000000000000"]
  #
  #   # On-premises writeback
  #   # writeback_enabled     = true
  #   # onpremises_group_type = "UniversalSecurityGroup"
  #
  #   # administrative_unit_ids = ["00000000-0000-0000-0000-000000000000"]
  # }
}
