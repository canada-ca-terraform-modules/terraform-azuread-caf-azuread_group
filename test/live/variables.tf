variable "env" {
  description = "4 chars defining the environment name prefix for the Group. Example: ScSc"
  type        = string
  default     = "livetest"
}

variable "userDefinedString" {
  description = "User defined portion of the Group name. Up to 8 chars minus the postfix length."
  type        = string
  default     = "grouplivetest"
}

variable "owners" {
  description = "A set of owners (UPNs) who own the Group created by this harness."
  type        = any
}

variable "pr_number" {
  description = <<-EOT
    Suffix reserved for parity with other module harnesses in case this
    module later grows a per-run resource dependency. azuread_group has no
    Azure resource dependency today (no RG/vnet - see test_dependencies
    note in README.md), so nothing here currently consumes this value.
    Manual runs can leave the default.
  EOT
  type        = string
  default     = "manual"
}
