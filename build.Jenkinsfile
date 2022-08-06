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
    	always{
    		archiveArtifacts artifacts: "target/myproject-*.jar", onlyIfSuccessful: true
    	}
        success {
        	echo 'Trigerring pipeline for generating docker image'
        	build job: 'Hello_world_dockerimage', wait: false
        }
    }
}
