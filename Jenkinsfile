#!groovy
properties(
        [[$class: 'GithubProjectProperty', projectUrlStr: 'https://github.com/contino/moj-core-infrastructure'],
         pipelineTriggers([[$class: 'GitHubPushTrigger']])]
)

@Library('Infrastructure')

import uk.gov.hmcts.contino.Terraform

def product = "applications-core-infra"

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

      stage('Terraform Plan - Applications ') {
          terraform.plan("applications")
      }

      stage('Terraform Apply - Applications') {
          terraform.apply("applications")
      }

    }

  }
  catch (err) {
    slackSend(
        channel: "#${uk-moj-pipeline}",
        color: 'danger',
        message: "${env.JOB_NAME}:  <${env.BUILD_URL}console|Build ${env.BUILD_DISPLAY_NAME}> has FAILED")
    throw err
  }

}
