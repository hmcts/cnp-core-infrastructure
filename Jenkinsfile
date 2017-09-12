#!groovy
@Library('Infrastructure@helpers-for-jenkins-test-steps')
import uk.gov.hmcts.contino.Terraform

//GITHUB_PROTOCOL = "https"
//GITHUB_REPO = "github.com/contino/moj-core-infrastructure/"

properties(
        [[$class: 'GithubProjectProperty', projectUrlStr: 'https://github.com/contino/moj-core-infrastructure'],
         pipelineTriggers([[$class: 'GitHubPushTrigger']])]
)

def product = "sandbox-core-infra"
def terraform = new Terraform(this, product)

withCredentials([string(credentialsId: 'sp_password', variable: 'ARM_CLIENT_SECRET'),
      string(credentialsId: 'tenant_id', variable: 'ARM_TENANT_ID'),
      string(credentialsId: 'contino_github', variable: 'TOKEN'),
      string(credentialsId: 'subscription_id', variable: 'ARM_SUBSCRIPTION_ID'),
      string(credentialsId: 'object_id', variable: 'ARM_CLIENT_ID')]) {
  try {
    node {

      stage('Checkout') {
        deleteDir()
        checkout scm
      }

      def envSuffix = (env.BRANCH_NAME == 'master') ? 'dev' : env.BRANCH_NAME

      lock("${product}-${envSuffix}") {
        stage("Terraform Plan - ${envSuffix}") {
            terraform.plan(envSuffix)
        }
  
        stage("Terraform Apply - ${envSuffix}") {
            terraform.apply(envSuffix)
        }

      }
    }

  }
  catch (err) {
    try {
      slackSend(
          channel: "#${uk - moj - pipeline}",
          color: 'danger',
          message: "${env.JOB_NAME}:  <${env.BUILD_URL}console|Build ${env.BUILD_DISPLAY_NAME}> has FAILED")
    } catch (errAgain) {
      throw errAgain
    }
    throw err
  }

}
