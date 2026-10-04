resource "random_string" "resource_suffix" {
  count       = var.name == null && var.legacy_name == null ? 1 : 0
  length      = 6
  min_lower   = 3
  min_numeric = 3
  special     = false
  upper       = false
}

resource "azurerm_storage_account" "main" {
  name                              = local.resource_name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = var.storage_account_tier
  account_replication_type          = var.storage_account_replication_type
  account_kind                      = var.storage_account_kind
  access_tier                       = var.storage_account_access_tier
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  min_tls_version                   = var.storage_account_min_tls_version
  public_network_access_enabled     = var.public_network_access_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  allow_nested_items_to_be_public   = local.allow_nested_items_to_be_public
  is_hns_enabled                    = local.is_hns_enabled
  tags                              = local.combined_tags

  dynamic "custom_domain" {
    for_each = var.storage_account_custom_domain
    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  dynamic "identity" {
    for_each = var.managed_identities
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, null)
    }
  }

  dynamic "static_website" {
    for_each = var.storage_account_static_website
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  lifecycle {
    ignore_changes = [customer_managed_key]
  }
}

module "containers" {
  source = "./modules/container"

  for_each = var.containers

  name                  = each.key
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = each.value.container_access_type
}

module "fileshares" {
  source = "./modules/fileshare"

  for_each = var.file_shares

  name               = each.key
  storage_account_id = azurerm_storage_account.main.id
  quota              = each.value.quota
  access_tier        = each.value.access_tier
}

resource "azurerm_storage_account_network_rules" "this" {
  for_each = {
    for idx, rule in var.storage_account_network_rules : tostring(idx) => rule
  }

  storage_account_id = azurerm_storage_account.main.id
  default_action     = each.value.default_action
  bypass             = each.value.bypass
  ip_rules           = each.value.ip_rules
  virtual_network_subnet_ids = each.value.virtual_network_subnet_ids

  depends_on = [
    module.fileshares,
    module.containers
  ]
}
