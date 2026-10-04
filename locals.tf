locals {
  resource_name = var.legacy_name != null ? var.legacy_name : (
    var.name != null ? var.name : "${var.resource_prefix}${var.environment != null ? var.environment : "dev"}${substr(replace(lower(var.location), " ", ""), 0, 3)}${random_string.resource_suffix[0].result}"
  )

  min_tags = {
    businessUnit       = ""
    costCentre         = ""
    createdDateTime    = ""
    dataClassification = ""
    environment        = var.environment != null ? var.environment : ""
    opsTeam            = ""
    owner              = ""
    workloadName       = ""
  }

  combined_tags = merge(local.min_tags, var.tags)

  allow_nested_items_to_be_public = (
    var.allow_nested_items_to_be_public != null
    ? var.allow_nested_items_to_be_public
    : var.storage_account_allow_nested_items_to_be_public
  )

  is_hns_enabled = (
    var.is_hns_enabled != null
    ? var.is_hns_enabled
    : var.storage_account_hns_enabled
  )
}