name = "core-infra"

address_space = "10.96.192.0/18"

env          = "demo"
subscription = "nonprod"

postgresql_subnet_cidr_blocks = ["10.96.221.0/24"]

common_tags = {
  environment = "demo"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}