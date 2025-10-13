name = "core-infra"

address_space = "10.96.64.0/18"

env          = "prod"
subscription = "prod"

postgresql_subnet_cidr_blocks = ["10.96.92.0/24"]

common_tags = {
  environment = "prod"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}

additional_subnets = [
  {
    name           = "postgresql"
    address_prefix = "10.96.92.0/24"
    delegation = {
      name = "fs"
      service_delegation = [
        {
          name    = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      ]
    }
  }
]