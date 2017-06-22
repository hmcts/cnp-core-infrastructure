resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-${var.name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.env}-${var.name}-vnet"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = "${var.address_space}"
  location            = "${azurerm_resource_group.rg.location}"
}

resource "azurerm_subnet" "sb" {
  count                = "${var.subnetinstance_count}"
  name                 = "${var.env}-${var.name}-subnet-${count.index}"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${element(var.address_prefixes,count.index)}"
}