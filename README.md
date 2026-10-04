# terraform-azurerm-storage-account

## Description

Terraform module to create and Azure Storage account and associated resources

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.56.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_containers"></a> [containers](#module\_containers) | ./modules/container | n/a |
| <a name="module_fileshares"></a> [fileshares](#module\_fileshares) | ./modules/fileshare | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [random_string.resource_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_containers"></a> [containers](#input\_containers) | n/a | <pre>map(object({<br>    storage_account_name  = optional(string)<br>    container_access_type = string<br>  }))</pre> | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | n/a | <pre>map(object({<br>    storage_account_name = optional(string)<br>    quota                = number<br>    access_tier          = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_legacy_name"></a> [legacy\_name](#input\_legacy\_name) | Optional.  Can be used to explicily name the storage account resource | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | n/a | yes |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | n/a | <pre>list(object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | n/a | `string` | `"sa"` | no |
| <a name="input_storage_account_access_tier"></a> [storage\_account\_access\_tier](#input\_storage\_account\_access\_tier) | n/a | `string` | `"Hot"` | no |
| <a name="input_storage_account_allow_nested_items_to_be_public"></a> [storage\_account\_allow\_nested\_items\_to\_be\_public](#input\_storage\_account\_allow\_nested\_items\_to\_be\_public) | n/a | `bool` | `false` | no |
| <a name="input_storage_account_custom_domain"></a> [storage\_account\_custom\_domain](#input\_storage\_account\_custom\_domain) | n/a | <pre>list(object({<br>    name          = string<br>    use_subdomain = bool<br><br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_hns_enabled"></a> [storage\_account\_hns\_enabled](#input\_storage\_account\_hns\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_storage_account_kind"></a> [storage\_account\_kind](#input\_storage\_account\_kind) | n/a | `string` | `"StorageV2"` | no |
| <a name="input_storage_account_min_tls_version"></a> [storage\_account\_min\_tls\_version](#input\_storage\_account\_min\_tls\_version) | n/a | `string` | `"TLS1_2"` | no |
| <a name="input_storage_account_network_rules"></a> [storage\_account\_network\_rules](#input\_storage\_account\_network\_rules) | n/a | <pre>list(object({<br>    default_action             = string<br>    bypass                     = optional(list(string))<br>    ip_rules                   = optional(list(string))<br>    virtual_network_subnet_ids = optional(list(string))<br>  }))</pre> | <pre>[<br>  {<br>    "bypass": [<br>      "AzureServices"<br>    ],<br>    "default_action": "Deny"<br>  }<br>]</pre> | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | n/a | `string` | `"LRS"` | no |
| <a name="input_storage_account_static_website"></a> [storage\_account\_static\_website](#input\_storage\_account\_static\_website) | n/a | <pre>list(object({<br>    index_document     = string<br>    error_404_document = string<br><br>  }))</pre> | `[]` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | n/a | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_containers"></a> [containers](#output\_containers) | n/a |
| <a name="output_fileshares"></a> [fileshares](#output\_fileshares) | n/a |
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | n/a |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | n/a |
| <a name="output_primary_blob_host"></a> [primary\_blob\_host](#output\_primary\_blob\_host) | n/a |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | n/a |
| <a name="output_primary_table_endpoint"></a> [primary\_table\_endpoint](#output\_primary\_table\_endpoint) | The endpoint URL for table storage in the primary location. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage
