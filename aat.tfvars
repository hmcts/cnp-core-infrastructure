name = "core-infra"

address_space = "10.96.128.0/18"

env          = "aat"
subscription = "nonprod"

postgresql_subnet_cidr_blocks = ["10.96.158.0/24"]

common_tags = {
  environment = "aat"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}