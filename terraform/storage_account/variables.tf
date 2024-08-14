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

variable "random_seed" {
  description = "The random seed to use for generating random resources"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Whether the storage account should have public network access enabled"
  default     = true
}

variable "containers" {
  description = "The containers to create in the storage account"
  default = []
  type = list(object({
    name                  = string
    public_access = optional(string, "None")
  }))
}

variable "queues" {
  description = "The queues to create in the storage account"
  default = []
  type = list(object({
    name = string
  }))
}
