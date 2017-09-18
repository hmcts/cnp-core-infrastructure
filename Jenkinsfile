#!groovy
@Library('Infrastructure') _

properties([[$class: 'GithubProjectProperty', projectUrlStr: 'https://github.com/contino/moj-core-infrastructure'],
 pipelineTriggers([[$class: 'GitHubPushTrigger']])]
)

product = "core-infra-sample"

try {
  node {
    platformSetup {

      stage('Checkout') {
        deleteDir()
        checkout scm
      }

      def envSuffix = (env.BRANCH_NAME == 'master') ? 'dev' : env.BRANCH_NAME
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
}
catch (err) {
  slackSend(
      channel: "#uk-moj-pipeline",
      color: 'danger',
      message: "${env.JOB_NAME}:  <${env.BUILD_URL}console|Build ${env.BUILD_DISPLAY_NAME}> has FAILED")
  throw err
}
