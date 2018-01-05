output "vnet_id" {
  value = "${module.vnet.vnet_id}"
}

output "vnetname" {
  value = "${module.vnet.vnetname}"
}

output "subnet_ids" {
  value = ["${module.vnet.subnet_ids}"]
}

output "subnet_names" {
  value = ["${module.vnet.subnet_names}"]
}

output "subnetaddress_prefixes" {
  value = ["${module.vnet.subnetaddress_prefixes}"]
}

output "resourcegroup_id" {
  value = "${module.vnet.resourcegroup_id}"
}

output "resourcegroup_name" {
  value = "${module.vnet.resourcegroup_name}"
}

output "vnetip" {
  value = "${module.vnet.address_space}"
}
