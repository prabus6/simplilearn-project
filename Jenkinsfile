pipeline {
    agent any
    tools{
        maven '3.9.6'
    }
    stages{
        stage('Build Maven'){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/prabus6/simplilearn-project.git']])
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    sh 'docker build -t prabus6/devops-integration .'
                }
            }
        }
        stage('Push image docker hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhubc', variable: 'dockerhubc')]) {
                    sh 'docker login -u prabus6 -p ${dockerhubc}'
}
                    sh 'docker push prabus6/devops-integration'
                }
            }
        }
    }
        
}