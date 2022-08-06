#!/usr/bin/env groovy
pipeline {
	agent any

    options {
        timestamps()
    }

    stages {
    	stage('Compile hello-world app '){
    		steps {
    			sh 'mvn compile'
        }
    	}

    	stage('Package app'){
    		steps{
    			sh 'mvn package'
    		}
    	}
    }
    post {
        success {
        	archiveArtifacts artifacts: "target/myproject-*.jar",
        	echo 'Trigerring pipeline for generating docker image'
        	build job: 'Hello_world_dockerimage', wait: false
        }
    }
}