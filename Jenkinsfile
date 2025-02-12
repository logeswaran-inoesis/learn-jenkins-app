pipeline {
    agent any
    environment {
        GIT_CREDENTIALS_ID = 'git-credentials'
        DOCKER_IMAGE = 'lokeshmani28/nextjsapplication'
        VERSION_TAG = "${BUILD_NUMBER}" // Use Jenkins build number as version tag
    }
    stages {
        stage('Clean Workspace') {
            steps {
                script {
                    echo "Cleaning workspace..."
                    sh 'rm -rf reactjs_jenkins'
                }
            }
        }
        stage('Clone Repository') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: GIT_CREDENTIALS_ID, usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        echo "Cloning the repository..."
                        sh '''
                        git clone https://${GIT_USER}:${GIT_PASS}@github.com/logeswaran-inoesis/reactjs_jenkins.git
                        '''
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    // Navigate to the project directory before building the image
                    dir('reactjs_jenkins') {
                        // Ensure we are in a Git repository before running git commands
                        sh 'git status'
                        def versionTag = "v${BUILD_NUMBER}" // Use Jenkins build number for version tag

                        echo "Building image with version tag: ${versionTag}"

                        // Build Docker image with both 'latest' and version-specific tags
                        sh """
                        docker build -t ${DOCKER_IMAGE}:latest -t ${DOCKER_IMAGE}:${versionTag} .
                        """
                    }
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        echo "Logging into Docker Hub..."
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image to Docker Hub..."
                    def versionTag = "v${BUILD_NUMBER}" // Reuse Jenkins build number for version tag
                    
                    sh """
                    docker push ${DOCKER_IMAGE}:latest
                    docker push ${DOCKER_IMAGE}:${versionTag}
                    """
                }
            }
        }
    }
}
