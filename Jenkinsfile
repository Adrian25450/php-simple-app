pipeline {
    agent any

    environment {
        IMAGE_NAME = 'adrian25450/php-simple-app' // Tu repo en DockerHub
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // ID de credencial en Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Adrian25450/php-simple-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    COMMIT_HASH = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    TAG = new Date().format("yyyyMMdd-HHmm") + "-${COMMIT_HASH}"
                    sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh """
                    echo "${DOCKERHUB_CREDENTIALS_PSW}" | docker login -u "${DOCKERHUB_CREDENTIALS_USR}" --password-stdin
                    docker push ${IMAGE_NAME}:${TAG}
                    docker logout
                    """
                }
            }
        }

        stage('Clean up') {
            steps {
                sh 'docker system prune -f'
            }
        }
    }

    post {
        success {
            echo "Pipeline ejecutado correctamente. Tag generado: ${TAG}"
        }
    }
}
