resource "azurerm_resource_group" "asprg" {
  name     = "mgmt-asp-${var.env}"
  location = "${var.location}"

  tags {
    environment = "${var.env}"
  }
}

module "vnet" {
  source                = "git::git@github.com:hmcts/cnp-module-vnet?ref=master"
  name                  = "${var.name}"
  location              = "${var.location}"
  address_space         = "${var.address_space}"
  source_range          = "${var.address_space}"
  env                   = "${var.env}"
  lb_private_ip_address = "${cidrhost("${cidrsubnet("${var.address_space}", 4, 2)}", -2)}"
}

module "api-mgmt" {
  source             = "git@github.com:hmcts/cnp-module-api-mgmt?ref=0.1.0"
  location           = "${var.location}"
  env                = "${var.env}"
  subscription       = "${var.subscription}"
  vnet_rg_name       = "${module.vnet.resourcegroup_name}"
  vnet_name          = "${module.vnet.vnetname}"
  source_range       = "${var.address_space}"
  source_range_index = "${length(module.vnet.subnet_ids)}"
}
