# moj-core-infrastructure

This repository shows how to create a Vnet, Subnet, and an Application Service Environment(ASE) deployed to a subnet.
This project lets you build base infrastructure for a compute environment defined in a Vnet and its associated Subnets.

## Variables
To use this project, the values specified in the following variables are used:-

name

location

address_space

address_prefixes

subnetinstance_count

env

You can see these variables in the variables.tf file, there are defaults already specified in this file, however you can set the variables using terraform variables, so you can set these values in a .tfvars file, or pass them in from a Jenkins file.  Due to this being the foundation infrastructure for the rest of your compute to live in there are a load of outputs produced by the running this terraform code, you can see all the outputs produced in the file output.tf.  Outputs are stored in remote state so that they can be referenced by other projects that will procur compute resource in a given subnet from this infrastructure.

The location and naming of the remote state file and directories is defined in the file Jenkinsfile, refer to the following code fragmemnt:-

```groovy
def state_store_resource_group = "contino-moj-tf-state"
def state_store_storage_acccount = "continomojtfstate"
def bootstrap_state_storage_container = "contino-moj-tfstate-container"
```
If you want to change the resource group, storage account, or storage container you can change the values above in the Jenkinsfile

Once this has been configured you can reference remote state data in your project code, this is where you would define you app services, please review the state.tf file in the repository moj-probate-infrastructure for examples of this.  The following code fragment shows how you can create a reference to data in remote state:-

```terraform
terraform {
  backend "azure" {}
}

data "terraform_remote_state" "core_apps_infrastructure" {
  backend = "azure"

  config {
    resource_group_name  = "contino-moj-tf-state"
    storage_account_name = "continomojtfstate"
    container_name       = "contino-moj-tfstate-container"
    key                  = "applications-core-infra/applications/terraform.tfstate"
  }
}
```

You can then reference values inside remote state

```terraform
  asename  = "${data.terraform_remote_state.core_apps_infrastructure.ase_name[0]}"
```

The line of code above is assigning the name of the pre-provisioned Application Service Environment(ase) to a variable, this is often done when provisioning a web app that you want to assign to a particular ASE.

## Usage
In order to use the code in this module to create a Vnet, Subnet and ASE, you will need to update a couple of values in two files.
these files are:-

- variables.tf
- Jenkinfile

The following variables need to be configured in the variables.tf 

```terraform
variable "address_space" {
  default = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "subnetinstance_count" {
  default = 2
}
```

The values in this file define the shape of your Vnet and Subnets, and the number of ASE's you have deployed in your Vnet.
You can define your own IP address ranges by modifying the address_space value.  You can define the subnets by modifying the address_prefixes list.
You can control how many of the subnets defined in the address_prefixes list are created by modifying the subnetinstance_count.  If you review the main.tf file you will see how the ASE's are created.  Consider the following code fragment:-

```terraform
module "azurerm_app_service_environment" {
  source            = "git::https://7fed81743d89f663cc1e746f147c83a74e7b1318@github.com/contino/moj-module-ase?ref=0.0.3"
  name              = "${var.name}"
  location          = "${var.location}"
  vnetresourceid    = "${azurerm_virtual_network.vnet.id}"
  subnetname        = "${azurerm_subnet.sb.0.name}"
  resourcegroupname = "${azurerm_subnet.sb.0.resource_group_name}"
  env               = "${var.env}"
}
```

The code example above lifted from main.tf in this repository shows how to create ASE, in a given subnet. as you can see this code is referencing the Vnet and Subnet.  This code uses a module that contains the logic to create ASE's, please refer to the repository moj-module-ase for further detail about this module.

The values that define the name and environment for a given Vnet you can be confgiured in the Jenkins file consider the following code fragment from the
Jenkins file in this repository:-

```groovy
def product = "core-infra"
def productEnv = "applications"
```

In the example above you can see two settings that can be configured product and productEnv. If we used the values specified above it would produce the following infrastructure named in the following way:-

- Resource group called application-core-infra
- Vnet called applications-core-infra-vnet
- Subnets called applications-core-infra-subnet-0, and applications-core-infra-subnet-1
- An Application Service Environment called applications-core-infra

## Testing

ToDo

## Unit Testing

ToDo

## Integration Testing

ToDo

## Terraform
All infrastructure provisioning is done using Terraform native azurerm provider where possible.  You can find the documentation for this at the following link:-

[Terraform azurerm](https://www.terraform.io/docs/providers/azurerm/index.html) <br />

## Jenkinsfile

The Jenkinsfile currently defines three stages:-

- Checkout code
- Run terraform plan
- Run terraform apply

If the plan is successfull then the changes are applied to the Infrastructure.  The Jenkins file leverages the Jenkins organisation plugin, such that it 
periodically scans all the organisation GitHub repo's and runs the build and deployment pipelines defined in the Jenkins file using Groovy code.

More information about Jenkins pipeline as code can be found at the following link:-

[Jenkins pipeline](https://jenkins.io/doc/book/pipeline/syntax/)

