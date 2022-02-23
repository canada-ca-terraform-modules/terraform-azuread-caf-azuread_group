# Example of resource_groups data structure:
# resource_groups = {
#   apim          = { 
#                     userDefinedString = "apim-demo"
#                   },
#   networking    = {    
#                     userDefinedString = "networking-demo"
#                     location          = "southeastasia"
#                     tags              = {
#                                           special = "special-location-needed"
#                                         }  
#                   },
#   insights      = { 
#                     userDefinedString = "insights-demo" 
#                   },
# }

variable "env" {
  description = "(Required) You can use a prefix to add to the list of resource groups you want to create"
  type        = string
}

variable "azuread_groupsMap" {
  description = "(Required) Map of azuread_groups"
  type        = any
}

variable "maxLength" {
  default = 80
  type    = number
}

variable "prevent_duplicate_names" {
  description = "If true, will return an error when an existing Group is found with the same name."
  type        = bool
  default     = true
}

variable "mail_enabled" {
  description = "Whether the group is a mail enabled, with a shared group mailbox. At least one of mail_enabled or security_enabled must be specified. Only Microsoft 365 groups can be mail enabled (see the types property)."
  type        = bool
  default     = false
}

variable "mail_nickname" {
  description = "The mail alias for the group, unique in the organisation. Required for mail-enabled groups. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "security_enabled" {
  description = "Whether the group is a mail enabled, with a shared group mailbox. At least one of mail_enabled or security_enabled must be specified. Only Microsoft 365 groups can be mail enabled (see the types property)."
  type        = bool
  default     = true
}

variable "description" {
  description = "The description for the group."
  type        = string
  default     = ""
}

variable "assignable_to_role" {
  description = "Indicates whether this group can be assigned to an Azure Active Directory role. Can only be true for security-enabled groups. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "behaviors" {
  description = "A set of behaviors for a Microsoft 365 group. Possible values are AllowOnlyMembersToPost, HideGroupInOutlook, SubscribeNewGroupMembers and WelcomeEmailDisabled. See official documentation for more details. Changing this forces a new resource to be created."
  type        = any
  default     = []
}

variable "types" {
  description = "A set of group types to configure for the group. The only supported type is Unified, which specifies a Microsoft 365 group. Required when mail_enabled is true. Changing this forces a new resource to be created."
  type        = any
  default     = []
}
