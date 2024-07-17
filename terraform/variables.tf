variable "salt" {
  description = "optional salt for use in the name"
  default     = ""
}

variable "location" {
  description = "default location to use if not specified"
  default     = "westeurope"
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
    name    = "text-embedding-ada-002"
    version = "2"
    capacity = "200"
    }, {
    name    = "gpt-4"
    version = "turbo-2024-04-09"
    capacity = "1"
  }]
  type = list(object({
    name    = string
    version = string
    capacity   = string
  }))

}
