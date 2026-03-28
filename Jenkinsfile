pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t trend-app:latest .'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push psakthiece/trend-app:latest'
      }
    }
    stage('Deploy') {
      steps {
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
      }
    }
  }
}

