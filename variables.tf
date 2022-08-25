variable "name" {
    description = "The Landing Zone name"
    type = string
    default = "grhoads_capstone_lz"
}

variable "location" {
    description = "The location zone for Landing Zone resources"
    type = string
    default = "eastus2" #centralus redundant partner region
}

variable "location2" {
    description = "backup/redundant region for Landing Zone Resources"
    type = string
    default = "centralus"
}

variable "rg1" {
    description = "The name of the landing zone resource group"
    type = string
    default = "landing_zone_rg"
}

variable "rg2" {
    description = "The name of the workload resource group"
    default = "workload_rg"
}

variable "tags" {
    description = "Additional tags to apply to resources"
    type = map(string)
    default = {}
}

variable "keyvaultname" {
    description = "name of keyvault you would like, only numbers and dashes"
    type = string
    default = "landing-zone-keyvault"
}

variable "vnetname" {
    description = "name of virtual network"
    type = string
    defualt = "landing-zone-network"
}

variable "subnet1name" {
    description = "name of first subnet for app"
    type = string
    default = "app-subnet"
}

variable "subnet2name" {
    description = "name of first subnet for data"
    type = string
    default = "data-subnet"
}

variable "subnet3name" {
    description = "name of first subnet for web"
    type = string
    default = "web-subnet"
}

variable "storage_account_name" {
    description = "name for the storage account in landing zone"
    type = string
    default = "grhoadsacelzstorage"
}

variable "storage_container_name" {
    description = "name for storage container"
    type = string
    default = "grhoadsacelzcontainer"
}

variable "blob_storage_name" {
    description = "name for blob inside container"
    type = string
    default = "grhoadsacelzblob"
}