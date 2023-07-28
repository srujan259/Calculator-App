pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE_NAME = 'srujan259/calculator-app'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        DOCKER_IMAGE_LATEST = "${DOCKER_IMAGE_NAME}:latest"
        REMOTE_USER = 'ubuntu'
        AWS_INSTANCE_IP = '16.170.141.2'
    }

    stages {
        stage('Build') {
            steps {
                // Build the Maven project
                sh 'mvn clean package'
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Build the Docker image and tag it with the build number and "latest"
                sh "docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_TAG} ."
                sh "docker tag ${DOCKER_REGISTRY}/${DOCKER_IMAGE_TAG} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_LATEST}"

                // Log in to the container registry using Docker Hub credentials
                withCredentials([string(credentialsId: 'dockerhub', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                    sh "docker login ${DOCKER_REGISTRY} -u ${DOCKER_HUB_CREDENTIALS_USR} -p ${DOCKER_HUB_CREDENTIALS_PSW}"
                }

                // Push the Docker images to the container registry
                sh "docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_TAG}"
                sh "docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_LATEST}"
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                // Log in to the AWS EC2 instance using SSH and run the Docker container
                sshagent(['AWS_PEM_KEY']) {
                    sh "ssh -o StrictHostKeyChecking=no -i ${AWS_PEM_KEY} ${REMOTE_USER}@${AWS_INSTANCE_IP} 'docker pull ${DOCKER_REGISTRY}/${DOCKER_IMAGE_LATEST}'"
                    sh "ssh -o StrictHostKeyChecking=no -i ${AWS_PEM_KEY} ${REMOTE_USER}@${AWS_INSTANCE_IP} 'docker stop calculator-app || true'"
                    sh "ssh -o StrictHostKeyChecking=no -i ${AWS_PEM_KEY} ${REMOTE_USER}@${AWS_INSTANCE_IP} 'docker rm calculator-app || true'"
                    sh "ssh -o StrictHostKeyChecking=no -i ${AWS_PEM_KEY} ${REMOTE_USER}@${AWS_INSTANCE_IP} 'docker run -d -p 4567:4567 --name calculator-app ${DOCKER_REGISTRY}/${DOCKER_IMAGE_LATEST}'"
                }
            }
        }
    }
}
