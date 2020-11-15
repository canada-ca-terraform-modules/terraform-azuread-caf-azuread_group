variable "env" {
  description = "4 chars defining the environment name prefix for the VM. Example: ScSc"
  type        = string
}

variable "maxLength" {
  description = "Maximum length of CAF compliant name"
  default     = 80
  type        = number
}

variable "userDefinedString" {
  description = "User defined portion of the server name. Up to 8 chars minus the postfix lenght"
  type        = string
}

variable "owners" {
  description = "A set of owners who own this Group. Supported Object types are Users or Service Principals."
  type        = any
  default     = null
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error when an existing Group is found with the same name."
  type        = bool
  default     = true
}