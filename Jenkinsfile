pipeline {
    agent any
    environment {
	     DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
         BRANCH_NAME="${env.GIT_BRANCH}"

    }
    stages {
	/*stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: '${env.BRANCH_NAME}', url: 'https://github.com/PraveenCodeDeveloper/CapstoneProject.git'
            }
        }*/
        stage('Build') {
            steps {
                script {
		   withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASS')]) {
                        
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASS'
           }
                    sh './build.sh "${BRANCH_NAME}"'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh './deploy.sh "${BRANCH_NAME}"'
                }
            }
        }
    }
    post {
        always {
            // Clean workspace after the build, regardless of the result
            cleanWs()
        }
        success {
            mail to: 'praveenkumarm1671@gmail.com',
                 subject: "Build Successful: ${env.JOB_NAME}",
                 body: "The build ${env.BUILD_NUMBER} was successful!"
        }
        failure {
            mail to: 'praveenkumarm1671@gmail.com',
                 subject: "Build Failed: ${env.JOB_NAME}",
                 body: "The build ${env.BUILD_NUMBER} failed. Please check the logs."
        }
    }
}

