module "vnet" {
  source           = "git::https://66ef3c054a0798d24a36f274c19041e92832687c@github.com/contino/moj-module-vnet?ref=master"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
}

module "waf" {
  source            = "git::https://66ef3c054a0798d24a36f274c19041e92832687c@github.com/contino/moj-module-waf?ref=master"
  product           = "${var.name}"
  location          = "${var.location}"
  env               = "${var.env}"
  vnetname          = "${module.vnet.vnet_id}"
  subnetname        = "${module.vnet.subnet_names[0]}"
  backendaddress    = "0.0.0.0"
  resourcegroupname = "${module.vnet.resourcegroup_name}"
}

resource "azurerm_virtual_network_peering" "vnetpeeringAtoB" {
  name                      = "peer-from-management"
  resource_group_name       = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_rg}"
  virtual_network_name      = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_name}"
  remote_virtual_network_id = "${module.vnet.vnet_id}"

  depends_on = ["module.vnet"]
}

resource "azurerm_virtual_network_peering" "vnetpeeringBtoA" {
  name                      = "peer-to-management"
  resource_group_name       = "${module.vnet.resourcegroup_name}"
  virtual_network_name      = "${module.vnet.vnetname}"
  remote_virtual_network_id = "${data.terraform_remote_state.vnetA_state.mgmt_vnet_id}"

  depends_on = ["module.vnet"]
}
