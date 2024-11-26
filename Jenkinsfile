pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'react-app:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/logeswaran-inoesis/learn-jenkins-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build -t $DOCKER_IMAGE .
                    '''
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    sh '''
                    docker-compose up -d
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker-compose down'
            }
        }
    }
}
