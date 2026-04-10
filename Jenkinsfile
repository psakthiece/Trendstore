pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "psakthiece/trend-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/psakthiece/Trendstore.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Use Dockerfile at repo root
                    sh "docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} -f Dockerfile ."
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage('Push') {
            steps {
                script {
                    sh "docker push ${DOCKER_HUB_REPO}:${IMAGE_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            echo "Application successfully built, pushed, and deployed!"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
