resource "random_string" "resource_suffix" {
  count       = var.legacy_name == null ? 1 : 0
  length      = 6
  min_lower   = 3
  min_numeric = 3
}

resource "azurerm_storage_account" "main" {
  name                      = substr(local.resource_name, 0, 23)
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.storage_account_tier
  account_replication_type  = var.storage_account_replication_type
  account_kind              = var.storage_account_kind
  access_tier               = var.storage_account_access_tier
  enable_https_traffic_only = true
  min_tls_version           = var.storage_account_min_tls_version
  #checkov:skip=CKV_AZURE_21:Default set by variable
  #checkov:skip=CKV_AZURE_33:Default set by variable
  #checkov:skip=CKV_AZURE_35:Default set by variable
  #checkov:skip=CKV_AZURE_59:Default set by variable
  #checkov:skip=CKV_AZURE_197:Default set by variable
  #checkov:skip=CKV2_AZURE_1:Default set by variable
  #checkov:skip=CKV2_AZURE_8:Default set by variable|
  #checkov:skip=CKV2_AZURE_18:Default set by variable
  #checkov:skip=CKV2_AZURE_34:Default set by variable  
  allow_nested_items_to_be_public = var.storage_account_allow_nested_items_to_be_public
  is_hns_enabled                  = var.storage_account_hns_enabled
  tags                            = local.combined_tags

  dynamic "custom_domain" {
    for_each = var.storage_account_custom_domain

    content {
      name          = custom_domain.value["name"]
      use_subdomain = custom_domain.value["use_subdomain"]
    }
  }

  dynamic "identity" {
    for_each = var.managed_identities

    content {
      type         = identity.value["type"]
      identity_ids = identity.value["identity_ids"]
    }
  }

  # dynamic "blob_properties" {
  #   for_each = lookup(var.storage_account_settings, "blob_properties", false) == false ? [] : [1]

  #   content {
  #     dynamic "cors_rule" {
  #       for_each = lookup(var.storage_account_settings.blob_properties, "cors_rule", false) == false ? [] : [1]

  #       content {
  #         allowed_headers    = var.storage_account_settings.blob_properties.cors_rule.allowed_headers
  #         allowed_methods    = var.storage_account_settings.blob_properties.cors_rule.allowed_methods
  #         allowed_origins    = var.storage_account_settings.blob_properties.cors_rule.allowed_origins
  #         exposed_headers    = var.storage_account_settings.blob_properties.cors_rule.exposed_headers
  #         max_age_in_seconds = var.storage_account_settings.blob_properties.cors_rule.max_age_in_seconds
  #       }
  #     }

  #     dynamic "delete_retention_policy" {
  #       for_each = lookup(var.storage_account_settings.blob_properties, "delete_retention_policy", false) == false ? [] : [1]

  #       content {
  #         days = lookup(var.storage_account_settings.blob_properties.delete_retention_policy, "delete_retention_policy", 7)
  #       }
  #     }
  #   }

  # }

  # dynamic "queue_properties" {
  #   for_each = lookup(var.storage_account_settings, "queue_properties", false) == false ? [] : [1]

  #   content {
  #     dynamic "cors_rule" {
  #       for_each = lookup(var.storage_account_settings.queue_properties, "cors_rule", false) == false ? [] : [1]

  #       content {
  #         allowed_headers    = var.storage_account_settings.queue_properties.cors_rule.allowed_headers
  #         allowed_methods    = var.storage_account_settings.queue_properties.cors_rule.allowed_methods
  #         allowed_origins    = var.storage_account_settings.queue_properties.cors_rule.allowed_origins
  #         exposed_headers    = var.storage_account_settings.queue_properties.cors_rule.exposed_headers
  #         max_age_in_seconds = var.storage_account_settings.queue_properties.cors_rule.max_age_in_seconds
  #       }
  #     }

  #     dynamic "logging" {
  #       for_each = lookup(var.storage_account_settings.queue_properties, "logging", false) == false ? [] : [1]

  #       content {
  #         delete                = var.storage_account_settings.queue_properties.logging.delete
  #         read                  = var.storage_account_settings.queue_properties.logging.read
  #         write                 = var.storage_account_settings.queue_properties.logging.write
  #         version               = var.storage_account_settings.queue_properties.logging.version
  #         retention_policy_days = lookup(var.storage_account_settings.queue_properties.logging, "retention_policy_days", 7)
  #       }
  #     }

  #     dynamic "minute_metrics" {
  #       for_each = lookup(var.storage_account_settings.queue_properties, "minute_metrics", false) == false ? [] : [1]

  #       content {
  #         enabled               = var.storage_account_settings.queue_properties.minute_metrics.enabled
  #         version               = var.storage_account_settings.queue_properties.minute_metrics.version
  #         include_apis          = lookup(var.storage_account_settings.queue_properties.minute_metrics, "include_apis", null)
  #         retention_policy_days = lookup(var.storage_account_settings.queue_properties.minute_metrics, "retention_policy_days", 7)
  #       }
  #     }

  #     dynamic "hour_metrics" {
  #       for_each = lookup(var.storage_account_settings.queue_properties, "hour_metrics", false) == false ? [] : [1]

  #       content {
  #         enabled               = var.storage_account_settings.queue_properties.hour_metrics.enabled
  #         version               = var.storage_account_settings.queue_properties.hour_metrics.version
  #         include_apis          = lookup(var.storage_account_settings.queue_properties.hour_metrics, "include_apis", null)
  #         retention_policy_days = lookup(var.storage_account_settings.queue_properties.hour_metrics, "retention_policy_days", 7)
  #       }
  #     }
  #   }
  # }

  dynamic "static_website" {
    for_each = var.storage_account_static_website

    content {
      index_document     = static_website.value["index_document"]
      error_404_document = static_website.value["error_404_document"]
    }
  }

  # Required to work around provider issue, where constant difference/change is introduced when applying a customer managed key
  lifecycle {
    ignore_changes = [
      customer_managed_key
    ]
  }
}

module "containers" {
  source = "./modules/container"

  for_each              = try(var.containers, {})
  name                  = each.key
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = each.value["container_access_type"]
}

module "fileshares" {
  source = "./modules/fileshare"

  for_each             = try(var.file_shares, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.main.name
  quota                = each.value["quota"]
  access_tier          = each.value["access_tier"]
}

resource "azurerm_storage_account_network_rules" "this" {
  count = length(var.storage_account_network_rules)
  depends_on = [
    module.fileshares,
    module.containers
  ]

  storage_account_id = azurerm_storage_account.main.id
  #checkov:skip=CKV_AZURE_35:Default set by variable
  default_action             = var.storage_account_network_rules[count.index].default_action
  bypass                     = coalesce(var.storage_account_network_rules[count.index].bypass, [])
  ip_rules                   = coalesce(var.storage_account_network_rules[count.index].ip_rules, [])
  virtual_network_subnet_ids = coalesce(var.storage_account_network_rules[count.index].virtual_network_subnet_ids, [])
}