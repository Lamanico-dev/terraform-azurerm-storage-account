variable "resource_prefix" {
  type    = string
  default = "sa"
}

variable "name" {
  description = "Exact storage account name. If null, the module generates a name unless legacy_name is supplied."
  type        = string
  default     = null
}

variable "legacy_name" {
  description = "Deprecated compatibility input. If supplied, takes precedence over name."
  type        = string
  default     = null
}

variable "location" {
  type = string
}

variable "environment" {
  description = "Optional environment value used for generated naming and default tags. Not required when name or legacy_name is supplied."
  type        = string
  default     = null
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_tier" {
  type    = string
  default = "Standard"
}

variable "storage_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_account_kind" {
  type    = string
  default = "StorageV2"
}

variable "storage_account_access_tier" {
  type    = string
  default = "Hot"
}

variable "storage_account_min_tls_version" {
  type    = string
  default = "TLS1_2"
}

variable "https_traffic_only_enabled" {
  description = "Whether HTTPS-only traffic is enforced for the storage account."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the storage account."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Whether shared access key authentication is enabled."
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Whether nested items within containers can be public."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Whether Hierarchical Namespace is enabled."
  type        = bool
  default     = false
}

# Existing compatibility variables retained
variable "storage_account_allow_nested_items_to_be_public" {
  type    = bool
  default = false
}

variable "storage_account_hns_enabled" {
  type    = bool
  default = false
}

variable "managed_identities" {
  type = list(object({
    type         = string
    identity_ids = optional(list(string))
  }))
  default = []
}

# variable storage_account_enable_system_msi {
#   type    = bool
#   default = false
# }

variable "storage_account_custom_domain" {
  type = list(object({
    name          = string
    use_subdomain = bool
  }))
  default = []
}

variable "storage_account_static_website" {
  type = list(object({
    index_document     = string
    error_404_document = string
  }))
  default = []
}

variable "storage_account_network_rules" {
  type = list(object({
    default_action             = string
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  }))

  default = [
    {
      default_action = "Deny"
      bypass = [
        "AzureServices"
      ]
    }
  ]
}

variable "containers" {
  type = map(object({
    storage_account_name  = optional(string)
    container_access_type = string
  }))
  default = {}
}

variable "file_shares" {
  type = map(object({
    storage_account_name = optional(string)
    quota                = number
    access_tier          = optional(string)
  }))
  default = {}
}

variable "tags" {
  type    = map(any)
  default = {}
}
