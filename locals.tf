locals {
  generated_location = substr(replace(lower(var.location), " ", ""), 0, 3)
  generated_environment = coalesce(var.environment, "dev")

  resource_name = var.name != null ? var.name : (
    var.legacy_name != null ? var.legacy_name : lower("${var.resource_prefix}${local.generated_environment}${local.generated_location}${random_string.resource_suffix[0].result}")
  )

  min_tags = {
    businessUnit       = ""
    costCentre         = ""
    createdDateTime    = ""
    dataClassification = ""
    environment        = coalesce(var.environment, "")
    opsTeam            = ""
    owner              = ""
    workloadName       = ""
  }

  combined_tags = merge(local.min_tags, var.tags)

  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public != null ? var.allow_nested_items_to_be_public : var.storage_account_allow_nested_items_to_be_public
  is_hns_enabled                  = var.is_hns_enabled != null ? var.is_hns_enabled : var.storage_account_hns_enabled
}
