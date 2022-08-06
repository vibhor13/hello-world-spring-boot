pipeline {
    agent {
        node {
            label 'gcp-node'
        }
    }
    stages{
        stage ('Call the deploy script . ') {
            steps{
                sh 'deploy_hello_world_container.sh'
            }
        }
    }
}
