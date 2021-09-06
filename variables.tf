variable "name" {
  type = string
}

variable "location" {
  default = "UK South"
}

variable "env" {
  type = string
}

variable "subscription" {}

variable "address_space" {}

variable "apim_subnet_address_prefix" {}

variable "product" {
  default = "core-infra"
}

variable "component" {
  default = ""
}

variable "common_tags" {
  type = map(string)
}

variable "virtual_network_type" {
  default = "External"
}
