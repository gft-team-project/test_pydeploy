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
         script {
           //cd ecr-create
           sh 'cd ecr-create && sudo terraform init'
           sh 'cd ecr-create && sudo terraform plan'
         }
       }
     }

stage('TF Apply') {
      steps {
        script {
          sh 'sudo terraform apply --auto-approve'
          sh 'cd ..'
        }
      }
    }
  }
}

