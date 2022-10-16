pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID=credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY=credentials('AWS_SECRET_ACCESS_KEY')
        JFROG_KEY=credentials('jfrog')
    }
    stages {
        stage('git checkout') {
            steps {
                git branch: 'main', credentialsId: 'git-rnaik', url: 'https://github.com/rknaik76/terraform.git'   
            }
        }
        stage('docker login') {
            steps {
                sh label: 'Docker login', script: 'docker login --username rknaik76@gmail.com --password ${JFROG_KEY}'
            }
        }
        stage('docker build') {
            steps {
                sh label: 'Docker build', script: 'docker build -t rknaik76.jfrog.io/drinks-docker/hellonode:latest .'
            }
        }
        stage('docker push') {
            steps {
                sh label: 'Docker push', script: 'docker push rknaik76.jfrog.io/drinks-docker/hellonode:latest'
            }
        }
    }
}
