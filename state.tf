terraform {
  backend "azure" {}
}

data "terraform_remote_state" "vnetA_state" {
  backend = "azure"

  config {
    resource_group_name  = "${var.vnetA_state_rg_name}"
    storage_account_name = "${var.vnetA_state_storageAccount_name}"
    container_name       = "${var.vnetA_state_container_name}"
    key                  = "${var.vnetA_state_key}"
  }
}
