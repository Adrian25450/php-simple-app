pipeline {
    agent any

    environment {
        IMAGE_NAME = 'adrian25450/php-simple-app' // tu repo DockerHub
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // credencial en Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Adrian25450/php-simple-app.git'
            }
        }

        stage('Generate Tag') {
            steps {
                script {
                    COMMIT_ID = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                    DATE_TAG = sh(returnStdout: true, script: 'date +%Y%m%d-%H%M%S').trim()
                    TAG = "${DATE_TAG}-${COMMIT_ID}"
                    echo "Tag generado: ${TAG}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh """
                    echo "${DOCKERHUB_CREDENTIALS_PSW}" | docker login -u "${DOCKERHUB_CREDENTIALS_USR}" --password-stdin
                    docker push ${IMAGE_NAME}:${TAG}
                    docker push ${IMAGE_NAME}:latest
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
            echo "✅ Pipeline ejecutado correctamente. Imagen subida con tag: ${TAG}"
        }
        failure {
            echo "❌ Error en la ejecución del pipeline."
        }
    }
}
