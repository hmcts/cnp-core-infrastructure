name = "core-infra"

address_space = "10.100.128.0/18"

env                  = "sandbox"
subscription         = "sandbox"
virtual_network_type = "Internal"

postgresql_subnet_cidr_blocks = ["10.100.163.0/24"]

common_tags = {
  environment = "sandbox"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}