pipeline{
    agent{label 'master'}
    
    environment {
        imagename = "rajenkarthikeyan/digitalbankproject_rk"
        registryCredential = 'KARTHIKEYAN'
        dockerImage = ''
	}
    tools{
        maven 'M3'
    }
    stages{
        stage('Checkout'){
            steps{
                git 'https://github.com/RajenKarthikeyan/Digital-Bank.git'
            }
        }
        stage('Build'){
            steps{
                 sh 'mvn clean compile'
            }
        }
        stage('Test'){
            steps{
                     sh 'mvn clean test'
                     junit '**/target/surefire-reports/TEST-*.xml'
            }
        }
        stage('Package'){
            steps{
                sh 'mvn clean package'
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
                }
        }
        stage('Deploy'){
	    steps {
                 script{
 		      input message: 'Kinldy click Proceed or Abort the Deployment'   
                      dockerImage = docker.build imagename
                      docker.withRegistry( '', registryCredential ) {
                            dockerImage.push("$BUILD_NUMBER")
                            dockerImage.push('latest')
                     }
		      sh "sudo docker run -d -p 8089:8080 rajenkarthikeyan/digitalbankproject_rk"
                 }
             } 
	}  
   }
}

