data "azurerm_subscription" "current" {}

data "azurerm_policy_definition" "policy" {
  for_each     = toset(var.security_policyset_definitions)
  display_name = each.key
}

resource "azurerm_policy_set_definition" "my_azure_policy_security_initiative" {
  name         = var.initiative_name
  policy_type  = "Custom"
  display_name = "My Security Initiative"
  description  = "Contains approved Security Governance policies"

  metadata = <<METADATA
    {
    "category": "${var.policyset_definition_category}"
    }
METADATA

  dynamic "policy_definition_reference" {
    for_each = data.azurerm_policy_definition.policy
    content {
      policy_definition_id = policy_definition_reference.value.id
    }
  }
}

resource "azurerm_subscription_policy_assignment" "my_subscription_policy_assignment" {
  count                = var.assign_to_subscription ? 1 : 0
  name                 = var.definition_assignment_name
  policy_definition_id = azurerm_policy_set_definition.my_azure_policy_security_initiative.id
  subscription_id      = data.azurerm_subscription.current.id
}

resource "azurerm_management_group_policy_assignment" "my_management_group_policy_assignment" {
  count                = var.assign_to_management_group && var.management_group_name != "" ? 1 : 0
  name                 = var.definition_assignment_name
  policy_definition_id = azurerm_policy_set_definition.my_azure_policy_security_initiative.id
  management_group_id  = var.management_group_name
}

data "azurerm_resource_group" "my_resource_group" {
  count = var.assign_to_resource_group && var.resource_group_name != "" ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group_policy_assignment" "my_resource_group_policy_assignment" {
  count               = var.assign_to_resource_group && var.resource_group_name != "" ? 1 : 0
  name                = var.definition_assignment_name
  policy_definition_id = azurerm_policy_set_definition.my_azure_policy_security_initiative.id
  resource_group_id   = data.azurerm_resource_group.my_resource_group[0].id
}