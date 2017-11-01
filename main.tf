module "vnet" {
  source           = "git::https://23a108ab5ea17c28372a130d72aa60ea0761839b@github.com/contino/moj-module-vnet?ref=master"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
}

module "waf" {
  source            = "git::https://23a108ab5ea17c28372a130d72aa60ea0761839b@github.com/contino/moj-module-waf?ref=master"
  product           = "${var.name}"
  location          = "${var.location}"
  env               = "${var.env}"
  vnetname          = "${module.vnet.vnet_id}"
  subnetname        = "${module.vnet.subnet_names[0]}"
  backendaddress    = "0.0.0.0"
  resourcegroupname = "${module.vnet.resourcegroup_name}"
}

data "azurerm_client_config" "current" {}

module "key_infra_vault" {
  source              = "git::https://23a108ab5ea17c28372a130d72aa60ea0761839b@github.com/contino/moj-module-key-vault?ref=master"
  name                = "moj-inf-vault"
  location            = "${var.location}"
  env                 = "${var.env}"
  resource_group_name = "${module.vnet.resourcegroup_name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"
  object_id           = "${data.azurerm_client_config.current.service_principal_object_id}"
  sites_obj_id        = "${var.sites_obj_id}"
}

module "key_app_vault" {
  source              = "git::https://23a108ab5ea17c28372a130d72aa60ea0761839b@github.com/contino/moj-module-key-vault?ref=master"
  name                = "moj-app-vault"
  location            = "${var.location}"
  env                 = "${var.env}"
  resource_group_name = "${module.vnet.resourcegroup_name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"
  object_id           = "${data.azurerm_client_config.current.service_principal_object_id}"
  sites_obj_id        = "${var.sites_obj_id}"
}
