#!groovy
@Library('Infrastructure') _

properties([
    parameters([
        string(name: 'PRODUCT_NAME', defaultValue: 'core-infra', description: ''),
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Suffix for resources created'),
        choice(name: 'SUBSCRIPTION', choices: 'nonprod\nprod\nsandbox\nhmctsdemo', description: 'Azure subscriptions available to build in'),
        booleanParam(name: 'PLAN_ONLY', defaultValue: false, description: 'set to true for skipping terraform apply')
    ])
])


productName = params.PRODUCT_NAME
subscription = params.SUBSCRIPTION
environment = params.ENVIRONMENT
planOnly = params.PLAN_ONLY

node {
  env.PATH = "$env.PATH:/usr/local/bin"
  def az = { cmd -> return sh(script: "env AZURE_CONFIG_DIR=/opt/jenkins/.azure-$subscription az $cmd", returnStdout: true).trim() }

  stageCheckout('git@github.com:contino/moj-core-infrastructure.git')

  withSubscription(subscription) {
    env.TF_VAR_netnum = findFreeSubnet(params.SUBSCRIPTION, params.ENVIRONMENT)[1]
    //steps to run before terraform plan and apply
    stage("Pick consul image") {


      // Looks for the latest image marked with release tag
      env.TF_VAR_vmimage_uri = az "image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION_NAME} --query \"[\*].{name:name, id:id, release:tags.version}\" -o tsv | grep moj-centos-consul | grep release | sort | awk 'END { print \$2 }'"
      
      // If no image can be found, deafults to the latest image available.
      if (env.TF_VAR_vmimage_uri.matches('image'))
      {
        echo "Picked following vmimage for consul: ${env.TF_VAR_vmimage_uri}"
      } else {
        env.TF_VAR_vmimage_uri = az "image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION_NAME} --query \"[?contains(name,'centos-consul')].{name: name, id: id}\" --output tsv | sort | awk 'END { print \$2 }'"
        echo "Didn't find a tagged release, picked  for consul: ${env.TF_VAR_vmimage_uri}"
      }

      
    }
    createwafcert()

    spinInfra(productName, environment, planOnly, subscription)

    peerVnets("mgmt-infra-${env.SUBSCRIPTION_NAME}", env.AZURE_SUBSCRIPTION_ID, environment, env.AZURE_SUBSCRIPTION_ID)
  }
}

