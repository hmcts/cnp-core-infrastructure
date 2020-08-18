name = "core-infra"

address_space = "10.112.128.0/18"

env = "perftest"
subscription = "qa"

common_tags = {
  environment = "perftest"

  changeUrl = ""

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}