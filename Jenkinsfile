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
                    // Point to Dockerfile inside Trend folder
                    sh "docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} -f Trend/Dockerfile Trend"
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    // Ensure you have created DockerHub credentials in Jenkins
                    // Replace 'dockerhub-credentials' with your actual Jenkins credentials ID
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
                    // Make sure kubectl is configured with the right context
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
