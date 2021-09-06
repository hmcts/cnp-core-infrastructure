name = "core-infra"

address_space = "10.100.128.0/18"
apim_subnet_address_prefix = "10.100.161.0/24"

env = "sandbox"
subscription = "sandbox"
virtual_network_type = "Internal"

common_tags = {
  environment = "sandbox"

  managedBy = "RPE"

  BuiltFrom = "https://github.com/hmcts/cnp-core-infrastructure"

  contactSlackChannel = "#rpe"
}
