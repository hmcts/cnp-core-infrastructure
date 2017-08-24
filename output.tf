output "id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "vnetname" {
  value = "${azurerm_virtual_network.vnet.name}"
}

output "subnet_ids" {
  value = ["${azurerm_subnet.sb.*.id}"]
}

output "subnet_names" {
  value = ["${azurerm_subnet.sb.*.name}"]
}

output "subnetaddress_prefixes" {
  value = ["${azurerm_subnet.sb.*.address_prefix}"]
}

output "resourcegroup_id" {
  value = "${azurerm_resource_group.rg.id}"
}

output "resourcegroup_name" {
  value = "${azurerm_resource_group.rg.name}"
}

/*output "ase_name" {
  value = ["${module.azurerm_app_service_environment.app_service_environment_name}"]
}

output "ase_location" {
  value = ["${azurerm_resource_group.rg.location}"]
}
*/