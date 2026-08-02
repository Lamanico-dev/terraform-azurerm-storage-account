resource "azurerm_storage_share" "main" {
  name                 = var.name
  storage_account_name = var.storage_account_name
  quota                = try(var.quota, 5120)
  access_tier          = var.access_tier

  lifecycle {
    ignore_changes = [
      metadata
    ]
  }
}
