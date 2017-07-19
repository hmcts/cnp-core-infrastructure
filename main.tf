resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-${var.env}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.env}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = "${var.address_space}"
  location            = "${azurerm_resource_group.rg.location}"
}

resource "azurerm_subnet" "sb" {
  count                = "${var.subnetinstance_count}"
  name                 = "${var.name}-subnet-${count.index}-${var.env}"
  resource_group_name  = "${azurerm_virtual_network.vnet.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${element(var.address_prefixes,count.index)}"
}

module "azurerm_app_service_environment" {
  source            = "git::https://7fed81743d89f663cc1e746f147c83a74e7b1318@github.com/contino/moj-module-ase?ref=0.0.3"
  name              = "${var.name}"
  location          = "${var.location}"
  vnetresourceid    = "${azurerm_virtual_network.vnet.id}"
  subnetname        = "${azurerm_subnet.sb.0.name}"
  resourcegroupname = "${azurerm_subnet.sb.resource_group_name}"
  env               = "${var.env}"
}
