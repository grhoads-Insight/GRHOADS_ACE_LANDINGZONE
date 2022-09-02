# GRHOADS_ACE_LANDINGZONE
landing zone as part of the ACE Capstone project

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.keyvault1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_resource_group.environment_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_blob.storageblob1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.storagecontainer1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_subnet.appsubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.datasubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.websubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_subnet_name"></a> [app\_subnet\_name](#input\_app\_subnet\_name) | name of first subnet for app | `string` | `"app-subnet"` | no |
| <a name="input_blob_storage_name"></a> [blob\_storage\_name](#input\_blob\_storage\_name) | name for blob inside container | `string` | `"grhoadslzblob"` | no |
| <a name="input_data_subnet_name"></a> [data\_subnet\_name](#input\_data\_subnet\_name) | name of first subnet for data | `string` | `"data-subnet"` | no |
| <a name="input_env"></a> [env](#input\_env) | environment name | `map(string)` | <pre>{<br>  "dev": "dev",<br>  "prod": "prod",<br>  "test": "test"<br>}</pre> | no |
| <a name="input_keyvault_name"></a> [keyvault\_name](#input\_keyvault\_name) | name of keyvault you would like, only numbers and dashes | `string` | `"grhoads-keyvault"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location zone for Landing Zone resources | `string` | `"eastus2"` | no |
| <a name="input_redundant_location"></a> [redundant\_location](#input\_redundant\_location) | backup/redundant region for Landing Zone Resources | `string` | `"centralus"` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the landing zone resource group | `string` | `"grhoads"` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | name for the storage account in landing zone | `string` | `"grhoadslzstorage"` | no |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | name for storage container | `string` | `"grhoadslzcontainer"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | name of virtual network | `string` | `"grhoads-vnet"` | no |
| <a name="input_web_subnet_name"></a> [web\_subnet\_name](#input\_web\_subnet\_name) | name of first subnet for web | `string` | `"web-subnet"` | no |

## Outputs

No outputs.