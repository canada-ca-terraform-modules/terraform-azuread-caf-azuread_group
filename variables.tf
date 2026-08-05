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
}

variable "name" {
  description = "(Optional) Override the auto-generated display name for the Group. Existing deployments whose real name diverges from the {env}-{userDefinedString} formula can pin it here without a destroy/recreate."
  type        = string
  default     = null
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
  description = "Whether the group is a security-enabled group. At least one of mail_enabled or security_enabled must be specified. A security-enabled group can be assigned to Azure AD roles when assignable_to_role is true."
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

variable "administrative_unit_ids" {
  description = "(Optional) The object IDs of administrative units in which the group is a member. If specified, new groups will be created in the scope of the first administrative unit and added to the others. If empty, new groups will be created at the tenant level."
  type        = any
  default     = null
}

variable "auto_subscribe_new_members" {
  description = "(Optional) Indicates whether new members added to the group will be auto-subscribed to receive email notifications. Can only be set for Unified groups."
  type        = bool
  default     = null
}

variable "dynamic_membership" {
  description = "(Optional) A dynamic_membership block (enabled, rule). Required when types contains DynamicMembership. Cannot be used with the members property."
  type        = any
  default     = null
}

variable "external_senders_allowed" {
  description = "(Optional) Indicates whether people external to the organization can send messages to the group. Can only be set for Unified groups."
  type        = bool
  default     = null
}

variable "hide_from_address_lists" {
  description = "(Optional) Indicates whether the group is displayed in certain parts of the Outlook user interface. Can only be set for Unified groups."
  type        = bool
  default     = null
}

variable "hide_from_outlook_clients" {
  description = "(Optional) Indicates whether the group is displayed in Outlook clients. Can only be set for Unified groups."
  type        = bool
  default     = null
}

variable "members" {
  description = "(Optional) A set of members who should be present in this group. Supported object types are Users, Groups or Service Principals. Cannot be used with the dynamic_membership block."
  type        = any
  default     = null
}

variable "onpremises_group_type" {
  description = "(Optional) The on-premises group type that the AAD group will be written as, when writeback is enabled. Possible values are UniversalDistributionGroup, UniversalMailEnabledSecurityGroup, or UniversalSecurityGroup."
  type        = string
  default     = null
}

variable "provisioning_options" {
  description = "(Optional) A set of provisioning options for a Microsoft 365 group. The only supported value is Team. Changing this forces a new resource to be created."
  type        = any
  default     = null
}

variable "theme" {
  description = "(Optional) The colour theme for a Microsoft 365 group. Possible values are Blue, Green, Orange, Pink, Purple, Red or Teal."
  type        = string
  default     = null
}

variable "visibility" {
  description = "(Optional) The group join policy and group content visibility. Possible values are Private, Public, or Hiddenmembership."
  type        = string
  default     = null
}

variable "writeback_enabled" {
  description = "(Optional) Whether the group will be written back to the configured on-premises Active Directory when Azure AD Connect is used."
  type        = bool
  default     = null
}
