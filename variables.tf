variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "env" {
  type = "string"
}

variable "vnetiprange" {}


variable "tenant_id" {}

variable "client_id" {}

variable "subscription_id" {}

variable "secret_access_key" {}

variable "lb_private_ip_address" {}

variable "vmimage_uri" {}
#variable "pfxPass" {}

variable "netnum" {}

