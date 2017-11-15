#!groovy
@Library('Infrastructure') _

properties([[$class: 'GithubProjectProperty', projectUrlStr: 'https://github.com/contino/moj-core-infrastructure'],
 pipelineTriggers([[$class: 'GitHubPushTrigger']])]
)

def product = "core-infra-sample"

withInfrastructurePipeline(product)
