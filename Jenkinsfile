#!groovy
//commenting as default brach (whatever is now used on jenkins) should be used now
@Library('Infrastructure@subscriptionsuffix') _

product = "core-infra"
platform = "pa"

node {
  env.PATH = "$env.PATH:/usr/local/bin"

  stage('Checkout') {
    deleteDir()
    git([url   : 'git@github.com:contino/moj-core-infrastructure.git',
         branch: 'private-ase'])
  }

  spinInfra(productName:"core-infra", environment:"pa", subscription:"nonprod", planOnly:true) {
    //steps to run before terraform plan and apply
    stage("Pick consul image") {
      env.TF_VAR_vmimage_uri = sh(script: "az image list --resource-group mgmt-vmimg-store-${env.SUBSCRIPTION} --query \"[?contains(name,'centos-consul')].{name: name, id: id}\" --output tsv | sort | awk 'END { print \$2 }'",
          returnStdout: true).trim()
      echo "Picked following vmimage for consul: ${env.TF_VAR_vmimage_uri}"
    }
    createwafcert()

  }
}
