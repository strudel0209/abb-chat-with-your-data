locals {
    rbac_policy_map = {
        key_permissions = {
            manage = "Key Vault Crypto Officer"
            read = "Key Vault Crypto User"
            contribute = "Key Vault Crypto User"
        }
        secret_permissions = {
            manage = "Key Vault Secrets Officer"
            read = "Key Vault Secrets User"
            contribute = "Key Vault Secrets Officer"
        }
        certificate_permissions = {
            manage = "Key Vault Certificates Officer"
            read = "Key Vault Certificates Officer"
            contribute = "Key Vault Certificates Officer"
        }
    }
}