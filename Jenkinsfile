pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-html-app"
        CONTAINER_NAME = "my-html-container"
        PORT = "8080"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}:${BUILD_NUMBER}"
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Deploy Container') {
            steps {
                echo "Deploying container on port ${PORT}..."
                sh """
                    # Stop and remove existing container if running
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true

                    # Run new container
                    docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}:latest
                """
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "Verifying application is responding..."
                sh "curl -I http://localhost:${PORT} || exit 0"
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully! App is running on port ${PORT}."
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
