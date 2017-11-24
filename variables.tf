variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "env" {
  type = "string"
}


variable "tenant_id" {}

variable "client_id" {}

variable "subscription_id" {}

variable "secret_access_key" {}

//variable "pfxPass" {}
