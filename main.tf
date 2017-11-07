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
}

module "consul" {
  source                      = "git::git@github.com/contino/moj-module-consul?ref=master"
  subscription_id             = "${var.subscription_id}"
  tenant_id                   = "${var.tenant_id}"
  client_id                   = "${var.client_id}"
  secret_access_key           = "${var.secret_access_key}"
  subnet_id                   = "${module.vnet.subnet_ids[2]}"
  storage_account_name        = "${var.storage_account_name}"
  allowed_inbound_cidr_blocks = ["10.0.0.0/16"]
  key_data                    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnpXKInabqAIqDb5Z9t2yvLNqvPZv5GdWCd1ZynHvk40h0IBLQDOeT0tbjP99ET1vzAQerpJ+QsdcT0OPuCZHITnyCkGlAnnIHX/R6F6YPuvUhJdOC9E5cknygu4IujhRU6QzmJmQ4IIkpuFPXDgi0qHhhVbGocyw3ucK/JGiiFzZTJ3yIH6EJcZkaohyE6C65FFl4LUHSWptc2fIGaM2tN2zLhRdnMdhzwMxblXpwUDEvOzADEvPuiJRanefugr27DNEbCIMxBqtRbhL0JBJ7slpi/5AQv/zDyX1+x15NgAgNRjWKm5bXhkIzJOD5RqVIS4MnhxV5Bmo8myH5nZbZ moj@jenkins"
  resource_group_name         = "${module.vnet.resourcegroup_name}"
  image_uri                   = "/subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourceGroups/mgmt-vmimg-store-prd/providers/Microsoft.Compute/images/moj-centos-consul-07112017"
  location                    = "${var.location}"
  cluster_name                = "consul"
}
