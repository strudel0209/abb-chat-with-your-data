variable "salt" {
  description = "optional salt for use in the name"
  default     = ""
}
# location for deployment
variable "location" {
  description = "default location to use if not specified"
  default     = "westeurope"
}

# Existing Virtual Network CIDR block
variable "vnet_cidr" {
  description = "CIDR block of the existing Virtual Network"
  type        = string
  default = "10.230.6.32/27"
}

# Existing Virtual Network Name
variable "virtual_network_name" {
  description = "Name of the existing Virtual Network"
  type        = string
  default = "WE-ACE-TST-Z1A-VNET34"
}
variable "secrets" {
  description = "list of secrets to add to the keyvault"
  default     = []
  type = list(object({
    name  = string
    value = string
  }))
}

variable "openai_embedding_models" {
  description = "list of embedding models to deploy"
  default = [{
    name     = "text-embedding-ada-002"
    version  = "2"
    capacity = 200
    }, {
    name    = "gpt-4"
    version = "turbo-2024-04-09"
    capacity = 150
  }]
  type = list(object({
    name     = string
    version  = optional(string, "1")
    capacity = optional(number, 1)
  }))

}
