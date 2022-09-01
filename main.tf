resource "azurerm_resource_group" "landing_zone_rg" {
  name     = var.lz_rg_name
  location = var.location
}

resource "azurerm_resource_group" "workload_rg" {
  name     = var.wl_rg_name
  location = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.landing_zone_rg.location
  resource_group_name         = azurerm_resource_group.landing_zone_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

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
  name                = var.vnet_name
  location            = azurerm_resource_group.landing_zone_rg.location
  resource_group_name = azurerm_resource_group.landing_zone_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "appsubnet" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.landing_zone_rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "appsubnet-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "datasubnet" {
  name                 = var.data_subnet_name
  resource_group_name  = azurerm_resource_group.landing_zone_rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
  delegation {
    name = "datasubnet-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet" "websubnet" {
  name                 = var.web_subnet_name
  resource_group_name  = azurerm_resource_group.landing_zone_rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.3.0/24"]
  delegation {
    name = "websubnet-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_storage_account" "storage1" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.landing_zone_rg.location
  resource_group_name      = azurerm_resource_group.landing_zone_rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "storagecontainer1" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage1.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storageblob1" {
  name                   = var.blob_storage_name
  storage_account_name   = azurerm_storage_account.storage1.name
  storage_container_name = azurerm_storage_container.storagecontainer1.name
  type                   = "Block"
}