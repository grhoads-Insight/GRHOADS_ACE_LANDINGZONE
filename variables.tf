variable "env" {
  description = "environment name"
  type        = map(string)
  default = {
    "dev"  = "dev"
    "test" = "test"
    "prod" = "prod"
  }
}

variable "location" {
  description = "The location zone for Landing Zone resources"
  type        = string
  default     = "eastus2" #centralus redundant partner region
}

variable "redundant_location" {
  description = "backup/redundant region for Landing Zone Resources"
  type        = string
  default     = "centralus"
}

variable "rg_name" {
  description = "The name of the landing zone resource group"
  type        = string
  default     = "grhoads"
}
variable "keyvault_name" {
  description = "name of keyvault you would like, only numbers and dashes"
  type        = string
  default     = "grhoads-keyvault"
}

variable "vnet_name" {
  description = "name of virtual network"
  type        = string
  default     = "grhoads-vnet"
}

variable "app_subnet_name" {
  description = "name of first subnet for app"
  type        = string
  default     = "app-subnet"
}

variable "data_subnet_name" {
  description = "name of first subnet for data"
  type        = string
  default     = "data-subnet"
}

variable "web_subnet_name" {
  description = "name of first subnet for web"
  type        = string
  default     = "web-subnet"
}

variable "storage_account_name" {
  description = "name for the storage account in landing zone"
  type        = string
  default     = "grhoadslzstorage"
}

variable "storage_container_name" {
  description = "name for storage container"
  type        = string
  default     = "grhoadslzcontainer"
}

variable "blob_storage_name" {
  description = "name for blob inside container"
  type        = string
  default     = "grhoadslzblob"
}