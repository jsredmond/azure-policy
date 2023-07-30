variable "security_policyset_definitions" {
  type        = list
  description = "List of policy definitions (display names) for the security_governance policyset"
  default = [
    "Internet-facing virtual machines should be protected with network security groups",
    "Subnets should be associated with a Network Security Group",
    "Gateway subnets should not be configured with a network security group",
    "Storage accounts should restrict network access",
    "Secure transfer to storage accounts should be enabled",
    "Storage accounts should allow access from trusted Microsoft services",
    "Automation account variables should be encrypted",
    "Azure subscriptions should have a log profile for Activity Log",
    "Email notification to subscription owner for high severity alerts should be enabled"
  ]
}

variable "policyset_definition_category" {
  description = "Category for the policy set definition"
  type        = string
  default     = "Security"
}

variable "assign_to_management_group" {
  type        = bool
  description = "Whether to assign the policy to a management group"
  default     = false
}

variable "assign_to_subscription" {
  type        = bool
  description = "Whether to assign the policy to a subscription"
  default     = true
}

variable "assign_to_resource_group" {
  type        = bool
  description = "Whether to assign the policy to a resource group"
  default     = false
}

variable "management_group_name" {
  description = "Management group name to assign the policy, if assign_to_management_group is set to true"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Resource group name to assign the policy, if assign_to_resource_group is set to true"
  type        = string
  default     = ""
}

variable "definition_assignment_name" {
  description = "Definition assignment name"
  type        = string
  default     = "My Security Azure Policy Initiative Assignment"
}

variable "initiative_name" {
  description = "Initiative name"
  type        = string
  default     = "My Security Azure Policy Initiative"
}