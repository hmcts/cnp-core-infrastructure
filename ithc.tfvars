name = "core-infra"

address_space = "10.112.0.0/18"

env = "ithc"
subscription = "qa"

common_tags = {
  environment = "ithc"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}