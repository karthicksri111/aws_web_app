pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/karthicksri111/aws_web_app']])
            }
        }
        stage('Init') {
            steps {
                sh ("terraform init -reconfigure")
            }
        }
        stage('Plan') {
            steps{
                sh ("terraform plan")
            }
        }
        stage('Action') {
            steps{
                sh ("terraform apply --auto-approve")
            }
        }
    }
}