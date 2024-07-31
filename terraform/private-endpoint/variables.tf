variable "name" {
    description = "The name of the service"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which the resources will be created"
    type        = string
}

variable "location" {
    description = "The location of the resources"
    type        = string
}

variable "vnet_id" {
    description = "The id of the virtual network"
    type        = string
}

variable "subnet_id" {
    description = "The id of the subnet"
    type        = string  
}

variable "service_type" {
    description = "The type of service"
    type        = string
}

variable "resources" {
    description = "The resources to create private endpoints for"
    type        = list(object({
        name = string
        id   = string
    }))
  
}