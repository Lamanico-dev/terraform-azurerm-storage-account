resource "azurerm_storage_blob" "main" {

  name                   = var.blob_settings.name
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = try(var.blob_settings.type, "Block")
  size                   = try(var.blob_settings.size, null)
  access_tier            = try(var.blob_settings.access_tier, "Hot")
  content_type           = try(var.blob_settings.content_type, null)
  source                 = try(var.blob_settings.source, null)
  source_content         = try(var.blob_settings.source_content, null)
  source_uri             = try(var.blob_settings.source_uri, null)
  parallelism            = try(var.blob_settings.parallelism, 8)
  metadata               = try(var.blob_settings.metadata, null)
}
