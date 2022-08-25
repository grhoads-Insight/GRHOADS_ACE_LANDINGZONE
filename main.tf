resource "azurerm_resource_group" "rg1" {
    name = var.rg1
    location = var.location
}

resource "azurerm_resource_group" "rg2" {
    name = var.rg2
    location = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
    name = "landing-zone-keyvault"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    enabled_for_disk_encryption = true
    tenant_id = data.azurerm_client_config.current.tenant_id
    soft_delete_retention_days = 7
    purge_protection_enabled = false

    sku_name = "standard"

    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id

        key_permissions = [
            "Get",
        ]

        secret_permissions = [
            "Get",
        ]

        storage_permissions = [
            "Get",
        ]
    }
}

resource "azurerm_virtual_network" "vnet1" {
    name = "landing-zone-network"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    address_space = [ "10.0.0.0/16" ]

    subnet = {
        name = "appsubnet"
        address_prefix = "10.0.1.0/24"
    }

    subnet = {
        name = "datasubnet"
        address_prefix = "10.0.2.0/24"
    }

    subnet = {
        name = "websubnet"
        address_prefix = "10.0.3.0/24"
    }
}