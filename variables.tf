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

#* details for infrastructure-bootstrap statefile
variable "vnetA_state_rg_name" {
  type = "string"
}

variable "vnetA_state_storageAccount_name" {
  type = "string"
}

variable "vnetA_state_container_name" {
  type = "string"
}

variable "vnetA_state_key" {
  description = "Location of state file for Resource Group that contains the vnet to be peered with local one including the .tfstate file name"
  type = "string"
}
