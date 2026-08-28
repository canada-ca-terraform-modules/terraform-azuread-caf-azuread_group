# config/azuread_group.tfvars
# Minimal, valid fixture exercising the module's common path: a plain
# security-enabled group with a single owner, no v1.4.0 optional arguments.
#
# The owner UPN below is the same account already used as a group owner in
# this org's L2 upgrade-probe harness for this module
# (G1Sc-CTO-ENT-ESLZ-Modules-Testing-and-Validation/L2_test_azuread_group) -
# a real, already-referenced tenant user, not a new secret.

userDefinedString = "grouplivetest"
owners = [
  "GCCloudOne-DevOps@ent.cloud-nuage.canada.ca"
]
