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

variable "postgresql_subnet_cidr_blocks" {
  type    = set(string)
  default = []
}

variable "builtFrom" {
  type = string
}

variable "environment" {
  type = string
}