variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "address_space" {
  default = ["10.98.0.0/15"]
}

variable "address_prefixes" {
  default = ["10.98.0.0/22", "10.98.4.0/22", "10.98.8.0/22", "10.98.12.0/22"]
}

variable "env" {
  type = "string"
}



variable "tenant_id" {}

variable "client_id" {}

variable "subscription_id" {}

variable "secret_access_key" {}

#variable "lb_private_ip_address" {
#  default = "10.98.8.4"
#}

variable "vmimage_uri" {}
#variable "pfxPass" {}

