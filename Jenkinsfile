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
          
         sh 'docker build -t flakapp' 
               }
           }
   }

}
}
