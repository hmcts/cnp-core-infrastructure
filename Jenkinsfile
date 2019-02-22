#!groovy
@Library('Infrastructure@cnp-1186') _

properties([
    parameters([
        string(name: 'PRODUCT_NAME', defaultValue: 'core-infra', description: ''),
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Suffix for resources created'),
        choice(name: 'SUBSCRIPTION', choices: 'nonprod\nprod\nsandbox\nhmctsdemo\nqa', description: 'Azure subscriptions available to build in'),
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

  stage('Checkout') {
    deleteDir()
    checkout scm
  }

  withSubscription(subscription) {
    env.TF_VAR_netnum = findFreeSubnet(params.SUBSCRIPTION, params.ENVIRONMENT)[1]
    //steps to run before terraform plan and apply
    
    createwafcert()

    spinInfra(productName, environment, planOnly, subscription)
    if (!planOnly) {
      peerVnets("mgmt-infra-${env.SUBSCRIPTION_NAME}", env.AZURE_SUBSCRIPTION_ID, environment, env.AZURE_SUBSCRIPTION_ID)
    }
  }
}

