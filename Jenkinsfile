pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE_NAME = 'srujan259/calculator-app'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        DOCKER_IMAGE_LATEST = "${DOCKER_IMAGE_NAME}:latest"

        // Add the DOCKER_HUB_CREDENTIALS variable here
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
    }

    stages {
        // ... Your stages here ...

        stage('Docker Build & Push') {
            steps {
                // ... Your steps here ...

                // Log in to the container registry using Docker Hub credentials
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_HUB_CREDENTIALS_PSW', usernameVariable: 'DOCKER_HUB_CREDENTIALS_USR')]) {
                    sh "docker login ${DOCKER_REGISTRY} -u ${DOCKER_HUB_CREDENTIALS_USR} -p ${DOCKER_HUB_CREDENTIALS_PSW}"
                }

                // ... Your steps here ...
            }
        }
    }
}
