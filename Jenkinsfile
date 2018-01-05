#!groovy
//commenting as default brach (whatever is now used on jenkins) should be used now
@Library('Infrastructure') _

properties([
    parameters([
        string(name: 'PRODUCT_NAME', defaultValue: 'core-infra', description: ''),
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Suffix for resources created'),
        choice(name: 'SUBSCRIPTION', choices: 'nonprod\nprod\nsandbox', description: 'Azure subscriptions available to build in'),
//        string(name: 'NETNUM', description: ' (Required IP Range) ÷ (2 power (32 – required bitmask) ). For example: To get 10.130.10.160/27, it would be (160) ÷ (2 power (32-27)) = (160) ÷ (32) = 5'),
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
    git([url: 'git@github.com:contino/moj-core-infrastructure.git'])
  }

  withSubscription(subscription) {
    //steps to run before terraform plan and apply
    stage("Pick consul image") {
      env.TF_VAR_vmimage_uri = sh(script: "az image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION_NAME} --query \"[?contains(name,'centos-consul')].{name: name, id: id}\" --output tsv | sort | awk 'END { print \$2 }'",
          returnStdout: true).trim()
      echo "Picked following vmimage for consul: ${env.TF_VAR_vmimage_uri}"
    }
    //create WAF certificate
    createwafcert()

    spinInfra(productName, environment, planOnly, subscription)
  }

}

