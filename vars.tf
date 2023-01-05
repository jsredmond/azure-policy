variable "security_policyset_definitions" {
  type        = list
  description = "List of policy definitions (display names) for the security_governance policyset"
  default = [
    "Internet-facing virtual machines should be protected with network security groups",
    "Subnets should be associated with a Network Security Group",
    "Gateway subnets should not be configured with a network security group",
    "Storage accounts should restrict network access",
    "Secure transfer to storage accounts should be enabled",
    "Access through Internet facing endpoint should be restricted",
    "Storage accounts should allow access from trusted Microsoft services",
    "RDP access from the Internet should be blocked",
    "SSH access from the Internet should be blocked",
    "Disk encryption should be applied on virtual machines",
    "Automation account variables should be encrypted",
    "Azure subscriptions should have a log profile for Activity Log",
    "Email notification to subscription owner for high severity alerts should be enabled",
    "A security contact email address should be provided for your subscription",
    "Enable Azure Security Center on your subscription"
  ]
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
  description = "Whether to assign the policy to a subscription"
  default     = false
}