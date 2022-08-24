variable "name" {
    description = "The Landing Zone name"
    type = string
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