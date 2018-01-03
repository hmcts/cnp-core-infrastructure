variable "name" {
  type = "string"
}

variable "location" {
  default = "UK South"
}

variable "address_space" {
//  default = ["10.100.0.0/15"]
}

variable "env" {
  type = "string"
}



variable "tenant_id" {}

variable "client_id" {}

variable "subscription_id" {}

variable "secret_access_key" {}

variable "lb_private_ip_address" {
  default = "10.100.8.4"
}

variable "vmimage_uri" {}
#variable "pfxPass" {}

