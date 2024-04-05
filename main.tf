module "ctags" {
  source = "git::https://github.com/hmcts/terraform-module-common-tags"
  environment  = var.environment
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}


resource "azurerm_resource_group" "core-infra" {
  name     = "core-infra-${var.env}"
  location = var.location

  tags = module.ctags.common_tags
}

module "vnet" {
  source                        = "git::https://github.com/hmcts/cnp-module-vnet?ref=fix-address-prefix"
  name                          = var.name
  location                      = var.location
  address_space                 = var.address_space
  source_range                  = var.address_space
  env                           = var.env
  lb_private_ip_address         = cidrhost(cidrsubnet(var.address_space, 4, 2), -2)
  postgresql_subnet_cidr_blocks = var.postgresql_subnet_cidr_blocks

  common_tags = module.ctags.common_tags
}

module "api-mgmt" {
  source               = "git::https://github.com/hmcts/cnp-module-api-mgmt?ref=master"
  location             = var.location
  env                  = var.env
  vnet_rg_name         = module.vnet.resourcegroup_name
  vnet_name            = module.vnet.vnetname
  source_range         = var.address_space
  source_range_index   = length(module.vnet.subnet_ids)
  virtual_network_type = var.virtual_network_type

  common_tags = module.ctags.common_tags
}

resource "azurerm_api_management_named_value" "environment-named-value" {
  name                = "environment"
  resource_group_name = module.vnet.resourcegroup_name
  api_management_name = module.api-mgmt.api_mgmt_name
  display_name        = "environment"
  value               = var.env
}
