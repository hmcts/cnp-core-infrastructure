name = "core-infra"

address_space = "10.112.128.0/18"

env          = "perftest"
subscription = "qa"

postgresql_subnet_cidr_blocks = ["10.112.155.0/24"]

postgresql_subnet_service_endpoints = ["Microsoft.Storage"]

common_tags = {
  environment = "perftest"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}