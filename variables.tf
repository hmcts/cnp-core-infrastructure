variable "name" {
  default = "core-applications-infrastructure"
}

variable "location" {
  default = "uksouth"
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
