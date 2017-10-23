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

variable "tenant_id" {
  type = "string"
}

variable "client_id" {
  type = "string"
}

variable "sites_obj_id" {
  default = "cc9a2807-e98c-485c-9c9f-7d991e58755c"
}
