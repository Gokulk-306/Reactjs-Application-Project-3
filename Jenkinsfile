pipeline {
    agent any

    environment {
        IMAGE_NAME_DEV = "gokulk306/react-nginx-app-dev"
        IMAGE_NAME_PROD = "gokulk306/react-nginx-app-prod"
        DOCKER_CRED = "docker-creds"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: env.BRANCH_NAME, url: 'https://github.com/Gokulk-306/Reactjs-Application-Project-3.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    IMAGE_TAG = new Date().format("yyyyMMddHHmm")
                    if(env.BRANCH_NAME == "dev") {
                        IMAGE = "${IMAGE_NAME_DEV}:${IMAGE_TAG}"
                        LATEST = "${IMAGE_NAME_DEV}:latest"
                    } else if(env.BRANCH_NAME == "main") {
                        IMAGE = "${IMAGE_NAME_PROD}:${IMAGE_TAG}"
                        LATEST = "${IMAGE_NAME_PROD}:stable"
                    }
                }
                sh "docker build -t ${IMAGE} ."
                sh "docker tag ${IMAGE} ${LATEST}"
            }
        }

        stage('Docker Push') {
            when { anyOf { branch 'dev'; branch 'main' } }
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CRED}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh """
                    echo "$PASS" | docker login -u "$USER" --password-stdin
                    docker push ${IMAGE}
                    docker push ${LATEST}
                    docker logout
                    """
                }
            }
        }

        stage('Deploy to Server (Prod only)') {
            when { branch 'main' }
            steps {
                sh """
                echo "Deploying Production Image..."
                docker pull ${LATEST}
                docker stop react-container || true
                docker rm react-container || true
                docker run -d -p 80:80 --name react-container ${LATEST}
                """
            }
        }
    }
}
