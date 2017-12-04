module "vnet" {
  source           = "git::git@github.com:contino/moj-module-vnet?ref=private-ase"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
  lb_private_ip_address = "${var.lb_private_ip_address}"
}

module "waf" {
  source            = "git::git@github.com:contino/moj-module-waf?ref=master"//private-ase"
  product           = "${var.name}"
  location          = "${var.location}"
  env               = "${var.env}"
  vnetname          = "${module.vnet.vnet_id}"
  subnetname        = "${module.vnet.subnet_names[0]}"
  backendaddress    = "0.0.0.0"
  resourcegroupname = "${module.vnet.resourcegroup_name}"
 // pfxPass           = "${var.pfxPass}"
}

module "consul" {
  source                      = "git::git@github.com:contino/moj-module-consul?ref=cnp-272"
  subscription_id             = "${var.subscription_id}"
  tenant_id                   = "${var.tenant_id}"
  client_id                   = "${var.client_id}"
  secret_access_key           = "${var.secret_access_key}"
  subnet_id                   = "${module.vnet.subnet_ids[2]}"
  storage_account_name        = "mgmtvmimgstore${var.env}"
  allowed_inbound_cidr_blocks = ["10.98.0.0/16"]
  key_data                    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDM/3NgLgH7/a6GZQ10O3PbzVMqM7hXPrRFXONaBRpIdSoBmRJGY531f4QPMKc4uS8PUqA8ClZ5MIMzqgD4zAmsB8eEnvEQ2dE7lW4rnaVphgoNr/MqxU3AQJsoJypOjDNp9xrjQqlco3OC2Ro1f+yOzj6FwonoGfD0I5DGtyKbSb1Pv8a8DbXILxju1ayBHCqwmhYCxrEH3yJlnB+KF/J5Q5u5oczsZBqzp0qC58TUpGkVqxFAk3zPwZxqny6xKNgGO9/gMKVjPMmTTiTa3MQHReG5JUSrHiMZe23/+QAClsflEAxhJeGf2h2jIBo3aQpcuc7ULzq2OhGG7dJ0VWwL"
  resource_group_name         = "${module.vnet.resourcegroup_name}"
  image_uri                   = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9/resourceGroups/consulimages/providers/Microsoft.Compute/images/consul-centos-2017-12-04-213556"
  location                    = "${var.location}"
  cluster_name                = "consul"
  lb_private_ip_address       = "${var.lb_private_ip_address}"

}
