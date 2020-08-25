# moj-core-infrastructure

This repository demonstrates how to create a Vnet, and Subnets to create the basic networking for running private workloads in Azure cloud.
This project lets you build base infrastructure for compute environments that can be defined in a Vnet and its associated Subnets.

## Variables
To use this project, the following variables are used:-

```groovy
name

location

address_space

env
```

You can see these variables in the variables.tf file, there are defaults already specified in this file, however you can set the variables using terraform variables in a .tfvars file, or pass them in from a Jenkins file.  Due to this being the foundation infrastructure for the rest of your compute to live in there are a load of outputs produced by the running this terraform code, you can see all the outputs produced in the file output.tf.  Outputs are stored in remote state so that they can be referenced by other projects that will procur compute resource in a given subnet from this base network infrastructure.

You can reference remote state data in your project code, this is where you would define you app services, please review the state.tf file in the repository moj-probate-infrastructure for examples of this.  The following code fragment shows how you can create a reference to data in remote state:-

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
    key                  = "applications-core-infra/dev/terraform.tfstate"
  }
}
```

You can then reference values inside remote state

```terraform
  asename  = "${data.terraform_remote_state.core_apps_infrastructure.ase_name[0]}"
```

The line of code above is assigning the name of the pre-provisioned Application Service Environment(ase) to a variable, this is often done when provisioning a web app that you want to assign to a particular ASE, please refer to moj-probate-infrastructure for more complete examples.

## Usage
In order to use the code in this module to create a Vnet, Subnets, you will need to update a couple of values in two files.
these files are:-

- variables.tf
- Jenkinfile

The following variables need to be configured in the variables.tf 

```terraform
variable "address_space" {
  default = ["10.0.0.0/16"]
}
```

For a suitable addressing scheme for private networking refer to the following article.

[Private Networking](https://en.wikipedia.org/wiki/Private_network) <br />

In order to ensure your network is private you should start with using:-

[RFC1918](https://tools.ietf.org/html/rfc1918) <br />
[RFC4193](https://tools.ietf.org/html/rfc4193) <br />

The values in the variables.tf file define the shape of your Vnet and Subnets.

The values that define the name and environment for a given Vnet can be configured in the Jenkinsfile, with the product part defined as a groovy var and the env as the parameter passed to the Terraform Jenkins library call. Consider the following code fragment from the Jenkinsfile in this repository:-

```groovy
def product = "applications-core-infra"
.
.
.
      lock("${product}-dev") {
        stage('Terraform Plan - Dev') {
            terraform.plan("dev")
        }

        stage('Terraform Apply - Dev') {
            terraform.apply("dev")
        }

      }
```

In the example above you can see settings that can be configured product and the env name to be used when running the terraform plan and apply commands (`dev` in this case). If we used the values specified above it would produce the following infrastructure named in the following way:-

- Resource group called application-core-infra
- Vnet called applications-core-infra-vnet
- Subnets called applications-core-infra-subnet-0, and applications-core-infra-subnet-1

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

