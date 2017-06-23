output "id" {
  value = "${module.vnet.id}"
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

output "subnet_ase_name" {
  value = "${module.vnet.subnet_gateway_name}"
}
