resource "azurerm_storage_container" "main" {
  name                 = var.name
  storage_account_name = var.storage_account_name

  #checkov:skip=CKV_AZURE_34:Default set by variable
  #checkov:skip=CKV2_AZURE_8:Default set by variable|
  #checkov:skip=CKV2_AZURE_21:Default set by variable
  container_access_type = var.container_access_type
  #metadata              = try(var.container_settings.metadata, null)
}

# module "blobs" {
#   source     = "../blob"
#   depends_on = [
#     azurerm_storage_container.main
#   ]

#   for_each   = try(var.container_settings.blobs, {})

#   storage_account_name   = var.storage_account_name
#   storage_container_name = var.container_settings.name
#   blob_settings               = each.value
# }
