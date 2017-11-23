#!groovy
@Library('Infrastructure@private-ase') _

product = "core-infra"
platform = "nonprod"

node {
  withSubscription(platform){

    stage('Checkout') {
      deleteDir()
      git([url   : 'git@github.com:contino/moj-core-infrastructure.git',
           branch: 'private-ase'])
    }

    def envSuffix = (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'private-ase') ? platform : env.BRANCH_NAME

    lock("${product}-${envSuffix}") {

      stage("Terraform Plan - ${envSuffix}") {
        terraform.ini(this)
        terraform.plan(envSuffix)
      }

      stage("Terraform Apply - ${envSuffix}") {
        terraform.apply(envSuffix)
      }
    }
  }
}
