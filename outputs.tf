output "id" {
  value = azurerm_storage_account.main.id
}

output "name" {
  value = azurerm_storage_account.main.name
}

output "location" {
  value = var.location

}

output "resource_group_name" {
  value = var.resource_group_name
}

output "primary_connection_string" {
  value     = azurerm_storage_account.main.primary_connection_string
  sensitive = true
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.main.primary_blob_endpoint
}

output "primary_blob_host" {
  value = azurerm_storage_account.main.primary_blob_host
}

output "primary_access_key" {
  value     = azurerm_storage_account.main.primary_access_key
  sensitive = true
}

output "containers" {
  value = [
    for key, value in module.containers : value.name
  ]
}

output "fileshares" {
  value = module.fileshares
}

output "primary_table_endpoint" {
  value       = azurerm_storage_account.main.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location."
}
