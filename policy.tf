data "azurerm_policy_definition" "security_policyset_definitions" {
  count        = length(var.security_policyset_definitions)
  display_name = var.security_policyset_definitions[count.index]
}

resource "azurerm_policy_set_definition" "security_governance" {

  name         = "security_governance"
  policy_type  = "Custom"
  display_name = "Security Governance"
  description  = "Contains common Security Governance policies"

  metadata = <<METADATA
    {
    "category": "${var.policyset_definition_category}"
    }
METADATA

  policy_definitions = <<POLICY_DEFINITIONS
    [
        {
            "policyDefinitionId": "${data.azurerm_policy_definition.security_policyset_definitions.*.id[0]}"
        },
        {
            "policyDefinitionId": "${data.azurerm_policy_definition.security_policyset_definitions.*.id[1]}"
        },
        {
            "policyDefinitionId": "${data.azurerm_policy_definition.security_policyset_definitions.*.id[2]}"
        },
    ]
POLICY_DEFINITIONS

  if var.assign_to_subscription == true {
    assignment {
      scope = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
    }
  } else if var.assign_to_management_group == true {
    assignment {
      scope = "${data.azurerm_management_group.selected.id}"
    }
  } else if var.assign_to_resource_group == true {
    assignment {
      scope = "${azurerm_resource_group.selected.id}"
    }
  }
}

output "policy_set_definition_metadata" {
  value = azurerm_policy_set_definition.security_governance.metadata
}

output "policy_set_definition_policy_type" {
  value = azurerm_policy_set_definition.security_governance.policy_type
}
