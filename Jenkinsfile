pipeline {
    agent any
    tools {
        maven 'maven'
        jdk 'jdk17'
    }
    stages {
        stage('compile') {
            steps {
                sh "echo 'start compile'"
                sh "mvn compile"
                sh "echo 'end compile'"
            }
        }
        stage('Test') {
            steps {
                sh "echo 'start test'"
                sh "mvn test"
                sh "echo 'end test'"
            }
        }
        stage('build') {
            steps {
                sh "echo 'start build'"
                sh "mvn package"
                sh "echo 'end build'"
            }
        }
        stage('Docker Build') {
            steps {
                sh "echo 'start Docker build'"
                sh "docker build -t eslammagdy/boardgame-app:v1 ."
                sh "docker run -d -p 4040:4040 eslammagdy/boardgame-app:v1"
                sh "echo 'end Docker build'"
            }
        }
    }
}

