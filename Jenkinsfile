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
                sh ("cd base && terraform init -reconfigure")
            }
        }
        stage('Plan') {
            steps{
                sh ("cd base && terraform plan")
            }
        }
        stage('Action') {
            steps{
                sh ("cd base && terraform apply --auto-approve")
            }
        }
    }
}
