locals {
  additional_subnets = [
    {
      name              = "postgresql"
      address_prefixes  = [var.postgresql_subnet_prefix]
      service_endpoints = ["Microsoft.Storage"]
      delegations = {
        fs = {
          name         = "fs"
          service_name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
    }
  ]
}