module "service_principal" {
    source  = "app.terraform.io/insight/terraform-app-registration/azuread"
    version = "~> 2.5.0"

    app_registration_name = "grhoads-terraform-ace-2022"
}

resource "azurerm_resource_group" "rg1" {
    name = var.rg1
    location = var.location
}

resource "azurerm_resource_group" "rg2" {
    name = var.rg2
    location = var.location
}