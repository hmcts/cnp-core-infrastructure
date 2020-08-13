variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "env" {
  type = "string"
}

variable "subscription" {}

variable "address_space" {}

variable "product" {}

variable "component" {}

variable "common_tags" {
  type = "map"
}
