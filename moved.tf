moved {
    from = module.vnet.azurerm_subnet.postgresql_subnet[0]
    to = module.vnet.azurerm_subnet.additional_subnets["postgresql"]
}