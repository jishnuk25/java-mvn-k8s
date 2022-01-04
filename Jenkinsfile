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
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                            sh 'mvn sonar:sonar'
                    }
                    timeout(2) {
                      def qg = waitForQualityGate()
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                        //note: if this step fails try with removing the tail "/" from sonar server url from the config in jenkins.
                    }
                }
            }
        }
        stage("docker build & push to nexus") {
            steps{
                script{
                    withCredentials([
                    string(credentialsId: 'nexus_address', variable: 'nexus_address'), 
                    usernamePassword(credentialsId: 'nexus_creds', passwordVariable:'nexus_password', usernameVariable: 'nexus_user')]){
                        docker build -t $nexus_address/loginapp:${VERSION}
                        docker login -u $nexus_user -p $nexus_password $nexus_address
                        docker push $nexus_address/loginapp:${VERSION}
                        docker rmi $nexus_address/loginapp:${VERSION}
                    }
                }
            }
        }
    }
}

