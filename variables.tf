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
}

variable "azuread_groupsMap" {
  description = "(Required) Map of azuread_groups"
}

variable "maxLength" {
  default = 80
  type    = number
}