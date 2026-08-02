variable "resource_prefix" {
  type    = string
  default = "sa"
}

variable "name" {
  type    = string
  default = null
}

variable "legacy_name" {
  type        = string
  default     = null
  description = "Optional.  Can be used to explicily name the storage account resource"
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
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
#     type = bool
#     default = false
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
