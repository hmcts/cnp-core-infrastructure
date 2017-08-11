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
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnetinstance_count" {
  default = 2
}

variable "env" {
  type = "string"
}
