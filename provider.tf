provider "azurerm" {
  version = "=2.22.0"
  features {}
}

provider "azurerm" {
  alias = "consul"
}