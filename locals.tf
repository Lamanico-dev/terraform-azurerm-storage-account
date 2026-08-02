locals {
  resource_name = var.legacy_name == null ? "${var.resource_prefix}${var.environment}${substr(var.location, 0, 3)}${var.name}${random_string.resource_suffix[0].result}" : var.legacy_name
  min_tags = {
    "businessUnit"       = ""
    "costCentre"         = ""
    "createdDateTime"    = ""
    "dataClassification" = ""
    "environment"        = var.environment
    "opsTeam"            = ""
    "owner"              = ""
    "workloadName"       = ""
  }

  combined_tags = merge(local.min_tags, var.tags)
}
