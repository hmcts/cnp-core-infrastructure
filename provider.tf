provider "azurerm" {
  version = "=0.22.0"
  features {}
}

provider "azurerm" {
  version = "=0.11.7"
  alias = "consul"
}