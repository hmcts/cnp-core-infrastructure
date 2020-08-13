# Temp
resource "azurerm_resource_group" "asprg" {
  name     = "mgmt-asp-${var.env}"
  location = "${var.location}"

  tags {
    environment = "${var.env}"
  }

  providers                   = {
    azurerm = "azurerm.previous"
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

# Temp
data "azurerm_image" "consul" {
  resource_group_name = "cnp-vmimages-${var.subscription}"
  name_regex = "moj-centos-consul-0.1.7"
  sort_descending = true
}

# Temp
module "consul" {
  source                      = "git::git@github.com:hmcts/cnp-module-consul?ref=consul-fix"
  subscription_id             = "${var.subscription_id}"
  tenant_id                   = "${var.tenant_id}"
  client_id                   = "${var.client_id}"
  secret_access_key           = "${var.secret_access_key}"
  subnet_id                   = "${module.vnet.subnet_ids[2]}"
  storage_account_name        = "mgmtvmimgstore${var.env}"
  allowed_inbound_cidr_blocks = ["${var.address_space}"]
  key_data                    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDM/3NgLgH7/a6GZQ10O3PbzVMqM7hXPrRFXONaBRpIdSoBmRJGY531f4QPMKc4uS8PUqA8ClZ5MIMzqgD4zAmsB8eEnvEQ2dE7lW4rnaVphgoNr/MqxU3AQJsoJypOjDNp9xrjQqlco3OC2Ro1f+yOzj6FwonoGfD0I5DGtyKbSb1Pv8a8DbXILxju1ayBHCqwmhYCxrEH3yJlnB+KF/J5Q5u5oczsZBqzp0qC58TUpGkVqxFAk3zPwZxqny6xKNgGO9/gMKVjPMmTTiTa3MQHReG5JUSrHiMZe23/+QAClsflEAxhJeGf2h2jIBo3aQpcuc7ULzq2OhGG7dJ0VWwL"
  resource_group_name         = "${module.vnet.resourcegroup_name}"
  image_uri                   = "${data.azurerm_image.consul.id}"
  location                    = "${var.location}"
  cluster_name                = "consul"
  instance_size               = "Standard_A2_v2"
  lb_private_ip_address       = "${cidrhost("${cidrsubnet("${var.address_space}", 4, 2)}", -2)}"

  providers                   = {
    azurerm = "azurerm.previous"
  }
}

module "api-mgmt" {
  source             = "git@github.com:hmcts/cnp-module-api-mgmt?ref=updated-for-core-infra"
  location           = "${var.location}"
  env                = "${var.env}"
  subscription       = "${var.subscription}"
  vnet_rg_name       = "${module.vnet.resourcegroup_name}"
  vnet_name          = "${module.vnet.vnetname}"
  source_range       = "${var.address_space}"
  source_range_index = "${length(module.vnet.subnet_ids)}"
}
