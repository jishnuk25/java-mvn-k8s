pipeline {
    agent any 
    environment {
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage("sonar quality check"){
            agent {
                docker {
                    image 'maven:latest'
                }
            }
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar_test') {
                            sh 'mvn sonar:sonar'
                    }
                    timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
                }
            }
        }
    }
}
