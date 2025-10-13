locals {
  additional_subnets = {
    postgresql = {
      address_prefixes = [var.postgresql_subnet_prefix]
      delegations = {
        fs = {
          service_name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}