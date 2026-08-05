mock_provider "azuread" {}

variables {
  env               = "Dev"
  userDefinedString = "grp01"
  owners            = ["owner@example.com"]
}

# Step 1: simulate the currently-deployed resource (pre-upgrade inputs only)
run "baseline_apply" {
  command = apply

  assert {
    condition     = azuread_group.group.display_name == "Dev-grp01"
    error_message = "Baseline apply: unexpected display_name"
  }
}

# Step 2: plan upgraded code (new optional args added) against that state
run "upgrade_plan_no_replacement" {
  command = plan

  variables {
    auto_subscribe_new_members = true
    theme                      = "Blue"
  }

  assert {
    condition     = azuread_group.group.display_name == "Dev-grp01"
    error_message = "display_name must be unchanged after upgrade"
  }

  assert {
    condition     = azuread_group.group.auto_subscribe_new_members == true
    error_message = "new auto_subscribe_new_members argument must be set without triggering replacement"
  }
}
