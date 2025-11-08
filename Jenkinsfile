pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'adrian0526'          // Tu usuario DockerHub
        IMAGE_NAME = 'php-simple-app'
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
                    def commitId = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    def dateTag = sh(script: "date +%Y%m%d-%H%M%S", returnStdout: true).trim()
                    env.TAG = "${dateTag}-${commitId}"
                    echo "🔖 Tag generado: ${env.TAG}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG} -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest .
                """
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'DOCKERHUB_CREDENTIALS',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${TAG}
                        docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completado correctamente."
        }
        failure {
            echo "❌ Error en la ejecución del pipeline."
        }
    }
}
