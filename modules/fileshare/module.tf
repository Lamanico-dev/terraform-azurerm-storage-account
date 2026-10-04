resource "azurerm_storage_share" "main" {
  name               = var.name
  storage_account_id = var.storage_account_id
  quota              = var.quota
  access_tier        = var.access_tier

  lifecycle {
    ignore_changes = [metadata]
  }
}
