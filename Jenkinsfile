pipeline{
    agent any
    stages{
        stage("Sonar-scanner"){
            steps{
                withSonarQubeEnv('sonarqube-scanner') {
                   sh """
                    #!/bin/bash
                    set -e
                    set -x
                    sonar-scanner \
                        -Dsonar.projectKey=your_project_key \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://your-sonarqube-server:9000 \
                        -Dsonar.login=$SONAR_AUTH_TOKEN
                        """
                }
            }
        }

        stage("Sonar-quality-gate"){
            steps{
                script {
                    timeout(time: 10, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }
        }
        stage("Install npm"){
            steps{
                sh "npm install"
            }
        }
        stage("Dependabcy-check"){
            steps{
                dependencyCheck additionalArguments: '--scan . --nodeAuditSkipDevDependencies', odcInstallation: 'OWASP-Dependency-Check'
        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
        }
        stage ("Trivy File Scan") {
            steps {
                sh "trivy fs . > trivy.txt"
            }
        }
        stage("Docker image build"){
            steps{
                sh "docker build -t boardgame-app ."
            }
        }
        stage("Docker image scan"){
            steps{
                sh "trivy image --severity HIGH,CRITICAL --exit-code 1 --no-progress boardgame-app"
            }
        }
        stage("Deploy Docker Container"){
            steps{
                sh "docker run -d -p 4040:4040 boardgame-app"
            }
        }
    }
}

