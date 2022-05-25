pipeline {
    agent { 
        label 'app'
    }

    stages {
        stage('ci') {
            steps {
                // Pull from repo
                git branch: 'app_deployment',
                    url: 'https://github.com/Stoon2/infra-config-deploy-devops.git'
                
                // Docker build
                sh 'docker build . -f Docker/jenkins_app_dockerfile -t stoon2/app-server'
                
                // Docker push
                withCredentials([usernamePassword(credentialsId: 'admin-dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'docker login --username stoon2 --password ${pass}'
                    sh 'docker push stoon2/app-server'
                }

                withCredentials([usernamePassword(credentialsId: 'rds-credentials', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'RDS_USERNAME=${user}'
                    sh 'RDS_PASSWORD=${pass}'
                }
                
                sh 'chmod +x util/set-env.sh'
                sh '.util/set-env.sh'
            }
        }
        stage('cd') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rds-credentials', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'docker run -d -p 3000:3000 --env-file /home/ubuntu/env-file -it stoon2/app-server'
                }
            }
        }
    }
}
