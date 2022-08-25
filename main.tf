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
}

resource "azurerm_subnet" "appsubnet" {
    name = "app-subnet"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_subnet" "datasubnet" {
    name = "data-subnet"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.0.2.0/24" ]
}

resource "azurerm_subnet" "websubnet" {
    name = "web-subnet"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name
    address_prefixes = [ "10.0.3.0/24" ]
}

resource "azurerm_storage_account" "storage1" {
    name = "grhoadsacelandingzonestorage"
    location = azurerm_resource_group.rg1.location
    resource_group_name = azurerm_resource_group.rg1.name
    account_tier = "Standard"
    account_replication_type = "GRS"
    account_kind = "StorageV2"
}