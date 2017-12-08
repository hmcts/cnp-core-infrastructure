#!groovy
//commenting as default brach (whatever is now used on jenkins) should be used now
@Library('Infrastructure@subscriptionsuffix') _

product = "core-infra"
platform = "pa"

node {
  env.PATH="$env.PATH:/usr/local/bin"
  withSubscription(platform){
    def envSuffix = (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'private-ase') ? platform : env.BRANCH_NAME

    stage('state store init') {
      stateStoreInit(platform)
    }

    stage('Checkout') {
      deleteDir()
      git([url   : 'git@github.com:contino/moj-core-infrastructure.git',
           branch: 'private-ase'])
    }

    lock("${product}-${envSuffix}") {

      env.TF_VAR_vmimage_uri=sh(script:"az image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION_SUFFIX} --query \"[?contains(name,'centos-consul')].{name: name, id: id}\" --output tsv | sort | awk 'END { print \$2 }'",
                                returnStdout:true).trim()
      echo "Picked following vmimage for consul: ${env.TF_VAR_vmimage_uri}"

      createwafcert()

      stage("Terraform Plan - ${envSuffix}") {
        terraform.ini(product, this)
        terraform.plan(envSuffix)
      }

      stage("Terraform Apply - ${envSuffix}") {
        terraform.apply(envSuffix)
      }
    }
  }
}
