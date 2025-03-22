locals {
  config = yamldecode(file("${path.module}/variables.yml"))
}

# Variables extraídas del YAML
# variable "resource_group_name" {
#   type    = string
#   default = local.config.resource_group_name
# }

# variable "cluster_name" {
#   type    = string
#   default = local.config.cluster_name
# }

# variable "location" {
#   type    = string
#   default = local.config.location
# }

# variable "subscription_id" {
#   type    = string
#   default = local.config.subscription_id
# }

# variable "storage_account_name" {
#   type    = string
#   default = local.config.storage_account_name
# }
