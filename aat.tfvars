name = "core-infra"

address_space = "10.96.128.0/18"

env = "aat"
subscription = "nonprod"

common_tags = {
  environment = "aat"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}