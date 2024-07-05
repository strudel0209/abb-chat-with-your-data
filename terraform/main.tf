terraform {
  backend "local" {
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

provider "namep" {
  slice_string                 = "abbchat mvp"
  default_location             = var.location
  default_nodash_name_format   = "#{SLUG}#{TOKEN_1}#{TOKEN_2}#{SHORT_LOC}#{NAME}#{SALT}"
  default_resource_name_format = "#{SLUG}-#{TOKEN_1}-#{TOKEN_2}-#{SHORT_LOC}-#{NAME}#{-SALT}"

  azure_resource_formats = {
    azurerm_storage_account = "sta#{TOKEN_1}#{NAME}#{SALT}#{RND}"
  }

  custom_resource_formats = {
    azurerm_logic_app_standard = "las-#{TOKEN_1}-#{TOKEN_2}-#{SHORT_LOC}-#{NAME}#{-SALT}-#{RND}"
  }

  extra_tokens = {
    salt = var.salt
    rnd = "NOT SET"
  }
}