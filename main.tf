resource "azurerm_resource_group" "environment_rg" {
  for_each = var.env
  name     = "${var.rg_name}-rg-${each.value}"
  location = var.location
  tags = {
    "Environment"   = "${each.value}"
    "Resource Type" = "Landing Zone"
  }
}

# resource "azurerm_resource_group" "workload_rg" {
#   name     = var.wl_rg_name
#   location = var.location
# }

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
  for_each                    = var.env
  name                        = "${var.keyvault_name}-${each.value}"
  location                    = azurerm_resource_group.environment_rg["${each.value}"].location
  resource_group_name         = azurerm_resource_group.environment_rg["${each.value}"].name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Get",
      "List",
    ]

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  }
  tags = {
    "Environment"   = "${each.value}"
    "Resource Type" = "Landing Zone"
  }
}
resource "azurerm_virtual_network" "vnet1" {
  for_each            = var.env
  name                = "${var.vnet_name}-${each.value}"
  location            = azurerm_resource_group.environment_rg["${each.value}"].location
  resource_group_name = azurerm_resource_group.environment_rg["${each.value}"].name
  address_space       = ["10.0.0.0/16"]
  tags = {
    "Environment"   = "${each.value}"
    "Resource Type" = "Landing Zone"
  }
}

resource "azurerm_subnet" "appsubnet" {
  for_each             = var.env
  name                 = "${var.app_subnet_name}-${each.value}"
  resource_group_name  = azurerm_resource_group.environment_rg["${each.value}"].name
  virtual_network_name = azurerm_virtual_network.vnet1["${each.value}"].name
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
  for_each             = var.env
  name                 = "${var.data_subnet_name}-${each.value}"
  resource_group_name  = azurerm_resource_group.environment_rg["${each.value}"].name
  virtual_network_name = azurerm_virtual_network.vnet1["${each.value}"].name
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
  for_each             = var.env
  name                 = "${var.web_subnet_name}-${each.value}"
  resource_group_name  = azurerm_resource_group.environment_rg["${each.value}"].name
  virtual_network_name = azurerm_virtual_network.vnet1["${each.value}"].name
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
  for_each                 = var.env
  name                     = "${var.storage_account_name}${each.value}"
  location                 = azurerm_resource_group.environment_rg["${each.value}"].location
  resource_group_name      = azurerm_resource_group.environment_rg["${each.value}"].name
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = {
    "Environment"   = "${each.value}"
    "Resource Type" = "Landing Zone"
  }
}

resource "azurerm_storage_container" "storagecontainer1" {
  for_each              = var.env
  name                  = "${var.storage_container_name}-${each.value}"
  storage_account_name  = azurerm_storage_account.storage1["${each.value}"].name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "storageblob1" {
  for_each               = var.env
  name                   = "${var.blob_storage_name}-${each.value}"
  storage_account_name   = azurerm_storage_account.storage1["${each.value}"].name
  storage_container_name = azurerm_storage_container.storagecontainer1["${each.value}"].name
  type                   = "Block"
}