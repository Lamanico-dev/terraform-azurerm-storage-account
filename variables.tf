variable "resource_prefix" {
  description = "Prefix used only when the module generates a storage account name."
  type        = string
  default     = "sa"
}

variable "name" {
  description = "Exact storage account name. If omitted, legacy_name is used, otherwise a name is generated."
  type        = string
  default     = null

  validation {
    condition = var.name == null || can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "name must be 3-24 lowercase alphanumeric characters when supplied."
  }
}

variable "legacy_name" {
  description = "Deprecated compatibility input for an exact storage account name. name is preferred."
  type        = string
  default     = null

  validation {
    condition = var.legacy_name == null || can(regex("^[a-z0-9]{3,24}$", var.legacy_name))
    error_message = "legacy_name must be 3-24 lowercase alphanumeric characters when supplied."
  }
}

variable "location" {
  description = "Azure region for the storage account."
  type        = string
}

variable "environment" {
  description = "Optional environment used only for generated naming/default tags."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Resource group containing the storage account."
  type        = string
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
  description = "Require HTTPS traffic to the storage account."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the storage account."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Whether shared-key authentication is enabled."
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Preferred input controlling public access for nested items."
  type        = bool
  default     = null
}

variable "storage_account_allow_nested_items_to_be_public" {
  description = "Legacy compatibility input for nested-item public access."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Preferred input controlling hierarchical namespace."
  type        = bool
  default     = null
}

variable "storage_account_hns_enabled" {
  description = "Legacy compatibility input controlling hierarchical namespace."
  type        = bool
  default     = false
}

variable "managed_identities" {
  type = list(object({
    type         = string
    identity_ids = optional(list(string))
  }))
  default = []
}

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
  description = "Optional storage-account network rules. Empty by default so callers opt in explicitly."
  type = list(object({
    default_action             = string
    bypass                     = optional(list(string), [])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  }))
  default = []
}

variable "containers" {
  type = map(object({
    storage_account_name  = optional(string)
    container_access_type = optional(string, "private")
  }))
  default = {}
}

variable "file_shares" {
  type = map(object({
    storage_account_name = optional(string)
    quota                = number
    access_tier          = optional(string, "Hot")
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
