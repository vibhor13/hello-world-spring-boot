#!/usr/bin/env groovy
pipeline {
    agent {
        node {
            label 'gcp-node'
        }
    }
    stages{
        stage ('Pull artifacts from Build hello-world app') {
            steps{
                copyArtifacts projectName: 'build_hello_world_app' ,filter: '*.jar', fingerprintArtifacts: true 
            }
        }
        stage('Build docker image .'){
            steps{
                sh 'docker build . -t vibhoranand/titaniam:webapp-$(date +"%s") -t vibhoranand/titaniam:webapp-latest'
            }
        }
        stage('Login and Push docker image to hub.docker.com - vibhoranand/titaniam'){
                steps{
                    withCredentials([usernamePassword(credentialsId: 'titaniam-dockerhub', passwordVariable: 'dockerhubPass', usernameVariable: 'dockerhubUser')]) {
                        sh 'docker login -u="$dockerhubUser" -p="$dockerhubPass"'
                        sh 'docker push vibhoranand/titaniam:webapp-$(date +"%s")'
                    }
                }
        }
    }
}
