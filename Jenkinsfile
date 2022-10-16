pipeline {
    agent any 
    stages {
        stage('Stage 1') {
            steps {
                echo 'Hello Hello world!' 
            }
        }
        stage('Docker Build') {
            steps {
      	        sh 'docker build -t node-web-app-01:latest .'
            }
        }
    }
}