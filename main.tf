module "vnet" {
  source           = "git::https://66ef3c054a0798d24a36f274c19041e92832687c@github.com/contino/moj-module-vnet?ref=master"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
}

//module "waf" {
//  source            = "git::https://66ef3c054a0798d24a36f274c19041e92832687c@github.com/contino/moj-module-waf?ref=master"
//  product           = "${var.name}"
//  location          = "${var.location}"
//  env               = "${var.env}"
//  vnetname          = "${module.vnet.vnet_id}"
//  subnetname        = "${module.vnet.subnet_names[0]}"
//  backendaddress    = "0.0.0.0"
//  resourcegroupname = "${module.vnet.resourcegroup_name}"
//}

resource "azurerm_virtual_network" "vnetA" {
  name                = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_name}"
  resource_group_name = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_rg}"
  address_space       = ["${data.terraform_remote_state.vnetA_state.mgmt_vnet_address_space}"]
  location            = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_location}"
}

resource "azurerm_virtual_network_peering" "vnetpeering" {
  name                      = "peerVnetAtoLocal"
  resource_group_name       = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_rg}"
  virtual_network_name      = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_name}"
  remote_virtual_network_id = "${module.vnet.id}"
}
