pipeline {
    agent any

    environment {
        IMAGE_REPO = 'hotel33/faruk_repo'
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Checked out from GitHub'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -f Dockerfile -t ${IMAGE_REPO}:${IMAGE_TAG} .
                    docker tag ${IMAGE_REPO}:${IMAGE_TAG} ${IMAGE_REPO}:latest
                """
            }
        }

        stage('Verify Image') {
            steps {
                sh 'docker images | grep faruk_repo'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-token',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker push ${IMAGE_REPO}:${IMAGE_TAG}
                        docker push ${IMAGE_REPO}:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo "SUCCESS: ${IMAGE_REPO}:${IMAGE_TAG} pushed to Docker Hub"
        }
        failure {
            echo 'FAILED - check Console Output'
        }
    }
}
