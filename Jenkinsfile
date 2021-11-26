pipeline {
agent any
 stages {
 stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/nwaykole/pydeploy.git']]])    
                  }
                      }

 // Building Docker images
    stage('Building image') 
  {
      steps{
        script {
          
         sh 'docker build -t flakapp .' 
               }
           }
   }
  
  //Creating AWS ECR registry terraform

 stage('TF Plan') {
       steps {
         container('terraform') {
           sh 'cd ecr-create'
           sh 'terraform init'
           sh 'terraform plan --auto-approve'
         }
       }
     }

stage('TF Apply') {
      steps {
        container('terraform') {
          sh 'terraform apply --auto-approve'
          sh 'cd ..'
        }
      }
    }
  }
}

