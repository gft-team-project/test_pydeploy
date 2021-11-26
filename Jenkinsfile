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
           sh 'cd ecr-create && terraform init'
           sh 'cd ecr-create && export AWS_ACCESS_KEY_ID=$[env.AWS_ACCESS_KEY_ID]'
          sh 'cd ecr-create && export AWS_SECRET_ACCESS_KEY=$[env.AWS_SECRET_ACCESS_KEY]'
          sh 'cd ecr-create && terraform plan'
         }
       }
     }

stage('TF Apply') {
      steps {
        script {
          sh 'terraform apply --auto-approve'
          sh 'cd ..'
        }
      }
    }
  }
}

