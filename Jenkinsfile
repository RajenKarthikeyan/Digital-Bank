pipeline{
    agent{label 'master'}
    environment {
        imagename = "yaminianand/digitalbank"
        registryCredential = 'DOCKERHUBCRED'
        dockerImage = ''
    }
    tools{
        maven 'M3'
    }

    stages {
        stage('Checkout'){
            steps{
                 git branch: 'main', url: 'https://github.com/yaminianand/Digital-Bank.git'
            }
        }

        stage('Build'){
            steps{
                 sh 'mvn clean compile'
            }
        }

        stage('Test'){
            steps{
                     sh 'mvn test'
                     junit '**/target/surefire-reports/TEST-*.xml'
            }
        }

        stage('Package'){
            steps{
                sh 'mvn package'
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                }
        }

	stage('Deploy'){
	    steps {
                 script{
 		      input message: 'Do you want to proceed with Deployment? (Click "Proceed" to continue)'   
                      dockerImage = docker.build imagename
                      docker.withRegistry( '', registryCredential ) {
                            dockerImage.push("$BUILD_NUMBER")
                            dockerImage.push('latest')
                      }
		      sh "sudo docker run -d -p 8087:8080 yaminianand/digitalbank"
                 }
             } 
	}  
   }
}

