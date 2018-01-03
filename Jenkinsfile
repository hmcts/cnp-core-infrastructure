#!groovy
//commenting as default brach (whatever is now used on jenkins) should be used now
@Library('Infrastructure') _

properties([
    parameters([
        string(name: 'PRODUCT_NAME', defaultValue: 'core-infra', description: ''),
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Suffix for resources created'),
        choice(name: 'SUBSCRIPTION', choices: 'nonprod\nprod\nsandbox', description: 'Azure subscriptions available to build in'),
        booleanParam(name: 'PLAN_ONLY', defaultValue: false, description: 'set to true for skipping terraform apply')
    ])
])


//running from another Jenkins file:
//   run(name: 'runname', projectName: 'moj-core-compute', description: '', filter: 'COMPLETED')
productName = params.PRODUCT_NAME
subscription = params.SUBSCRIPTION
environment = params.ENVIRONMENT
planOnly = params.PLAN_ONLY

node {
  env.PATH = "$env.PATH:/usr/local/bin"

  stage('Checkout') {
    deleteDir()
    git([url   : 'git@github.com:contino/moj-core-infrastructure.git',
         branch: 'master'])  //TODO: should pick the branch it is running from
  }

  withSubscription(subscription) {

    TF_VAR_address_space:
      if prod         -> 10.98.0.0/15
      else if nonprod -> 10.100.0.0/15
           else find empty 10.[102,104,106,108,110].0.0/15

    TF_VAR_address_prefixes = ["10.x.0.0/22", "10.x.4.0/22", "10.x.8.0/22", "10.x.12.0/22"]

    //steps to run before terraform plan and apply
    stage("Pick consul image") {
      env.TF_VAR_vmimage_uri = sh(script: "az image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION_NAME} --query \"[?contains(name,'centos-consul')].{name: name, id: id}\" --output tsv | sort | awk 'END { print \$2 }'",
          returnStdout: true).trim()
      echo "Picked following vmimage for consul: ${env.TF_VAR_vmimage_uri}"
    }
    createwafcert()

    spinInfra(productName, environment, planOnly, subscription)
  }

}

