resource "random_string" "resource_suffix" {
  count       = var.legacy_name == null && var.name == null ? 1 : 0
  length      = 6
  min_lower   = 3
  min_numeric = 3
}

resource "azurerm_storage_account" "main" {
  name                       = substr(local.resource_name, 0, 24)
  resource_group_name        = var.resource_group_name
  location                   = var.location
  account_tier               = var.storage_account_tier
  account_replication_type   = var.storage_account_replication_type
  account_kind               = var.storage_account_kind
  access_tier                = var.storage_account_access_tier
  https_traffic_only_enabled = var.https_traffic_only_enabled
  min_tls_version            = var.storage_account_min_tls_version

  public_network_access_enabled = var.public_network_access_enabled
  shared_access_key_enabled     = var.shared_access_key_enabled

  #checkov:skip=CKV_AZURE_21:Default set by variable
  #checkov:skip=CKV_AZURE_33:Default set by variable
  #checkov:skip=CKV_AZURE_35:Default set by variable
  #checkov:skip=CKV_AZURE_36:Default set by variable
  #checkov:skip=CKV2_AZURE_1:Default set by variable
  #checkov:skip=CKV2_AZURE_8:Default set by variable
  #checkov:skip=CKV2_AZURE_18:Default set by variable
  #checkov:skip=CKV2_AZURE_34:Default set by variable

  allow_nested_items_to_be_public = local.allow_nested_items_to_be_public
  is_hns_enabled                  = local.is_hns_enabled
  tags                            = local.combined_tags

  dynamic "custom_domain" {
    for_each = var.storage_account_custom_domain

    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  dynamic "static_website" {
    for_each = var.storage_account_static_website

    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  dynamic "network_rules" {
    for_each = var.storage_account_network_rules

    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }
}
