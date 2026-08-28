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
