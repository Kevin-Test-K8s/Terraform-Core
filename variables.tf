variable "resource_group_name" {
  type    = string
  default = "k8s-terraform"
}

variable "cluster_name" {
  type    = string
  default = "k8s-terraform-cluster"
}

variable "location" {
  type    = string
  default = "West Europe"
}
