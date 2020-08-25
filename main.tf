module "vnet" {
  source                = "git@github.com:hmcts/cnp-module-vnet?ref=fix-address-prefix"
  name                  = var.name
  location              = var.location
  address_space         = var.address_space
  source_range          = var.address_space
  env                   = var.env
  lb_private_ip_address = cidrhost(cidrsubnet(var.address_space, 4, 2), -2)

  common_tags           = {
    "environment" = var.env
  }
}

module "api-mgmt" {
  source             = "git@github.com:hmcts/cnp-module-api-mgmt?ref=updated-for-core-infra"
  count              = var.api_mgmt_count
  location           = var.location
  env                = var.env
  subscription       = var.subscription
  vnet_rg_name       = module.vnet.resourcegroup_name
  vnet_name          = module.vnet.vnetname
  source_range       = var.address_space
  source_range_index = length(module.vnet.subnet_ids)
}
