module "vnet" {
  source           = "git::https://7fed81743d89f663cc1e746f147c83a74e7b1318@github.com/contino/moj-module-vnet?ref=master"
  name             = "${var.name}"
  location         = "${var.location}"
  address_space    = "${var.address_space}"
  address_prefixes = "${var.address_prefixes}"
  env              = "${var.env}"
}
