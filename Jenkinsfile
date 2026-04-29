pipeline {
    agent any

    environment {
        IMAGE_NAME = "kkdochub/devops-build"
        TAG = "dev"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'dev', url: 'https://github.com/Koushik-8arch/devops-build.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME:$TAG ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push $IMAGE_NAME:$TAG"
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f react-app || true
                    docker run -d -p 80:80 --name react-app $IMAGE_NAME:$TAG
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful 🚀"
        }
        failure {
            echo "Deployment Failed ❌"
        }
    }
}
