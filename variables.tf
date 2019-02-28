variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "env" {
  type = "string"
}

variable "tenant_id" {}

variable "client_id" {}

variable "subscription" {}

variable "subscription_id" {}

variable "secret_access_key" {}

variable "netnum" {}

//variable "root_address_space" {}
variable "address_space" {}
