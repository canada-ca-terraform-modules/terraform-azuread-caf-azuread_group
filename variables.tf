variable "env" {
  description = "(Required) You can use a prefix to add to the list of resource groups you want to create"
}

variable "maxLength" {
  default = 80
  type    = number
}

variable "userDefinedString" {
  type = string
}

variable "owners" {}

variable "prevent_duplicate_names" {
  type    = bool
  default = true
}