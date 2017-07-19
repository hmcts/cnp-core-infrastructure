variable "azure_subscription" {
  type = "string"
}

variable "azure_client_id" {
  type = "string"
}

variable "azure_client_secret" {
  type = "string"
}

variable "azure_tenant_id" {
  type = "string"
}

variable "name" {
  type    = "string"
  default = "mo-environment"
}

variable "location" {
  default = "UK South"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  default = ["10.0.0.0/24"]
}

variable "subnetinstance_count" {
  default = 1
}

variable "env" {
  type    = "string"
  default = "dev"
}
