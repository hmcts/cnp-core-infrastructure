resource "azurerm_subnet" "api-mgmt-subnet" {
  name                 = "core-infra-subnet-apimgmt-${var.env}"
  resource_group_name  = "${module.vnet.resourcegroup_name}"
  virtual_network_name = "${module.vnet.vnetname}"
  address_prefixes     = "${cidrsubnet("${var.address_space}", 4, length(module.vnet.subnet_ids))}"

  lifecycle {
    ignore_changes = [address_prefixes]
  }
}

module "vnet" {
  source                = "git::git@github.com:hmcts/cnp-module-vnet?ref=fix-address-prefix"
  name                  = "${var.name}"
  location              = "${var.location}"
  address_space         = "${var.address_space}"
  source_range          = "${var.address_space}"
  env                   = "${var.env}"
  lb_private_ip_address = "${cidrhost("${cidrsubnet("${var.address_space}", 4, 2)}", -2)}"
}

module "api-mgmt" {
  source             = "git@github.com:hmcts/cnp-module-api-mgmt?ref=master"
  location           = "${var.location}"
  api_subnet_id      = "${azurerm_subnet.api-mgmt-subnet.id}"
  env                = "${var.env}"
  vnet_rg_name       = "${module.vnet.resourcegroup_name}"
}
