module "vnet" {
  source           = "git::git@github.com:contino/moj-module-vnet?ref=master"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
}

module "waf" {
  source            = "git::git@github.com:contino/moj-module-waf?ref=master"
  product           = "${var.name}"
  location          = "${var.location}"
  env               = "${var.env}"
  vnetname          = "${module.vnet.vnet_id}"
  subnetname        = "${module.vnet.subnet_names[0]}"
  backendaddress    = "0.0.0.0"
  resourcegroupname = "${module.vnet.resourcegroup_name}"
  pfxPass           = "${var.pfxPass}"
}
