pipeline {
    agent { 
        label 'app'
    }

    stages {
        stage('ci') {
            steps {
                // Pull from repo
                git branch: 'app_deployment'
                    url: 'https://github.com/mahmoud254/jenkins_nodejs_example.git'
                
                // Docker build
                sh 'docker build . -f Docker/jenkins_app_dockerfile -t stoon2/app-server'
                
                // Docker push
                withCredentials([usernamePassword(credentialsId: 'admin-dockerhub', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'docker login --username ${user} --password ${pass}'
                    sh 'docker push stoon2/app-server'
                }

                withCredentials([usernamePassword(credentialsId: 'rds-credentials', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'RDS_USERNAME=${user}'
                    sh 'RDS_PASSWORD=${pass}'
                }
            }
        }
        stage('cd') {
            steps {
                sh 'docker run -d -p 3000:3000 stoon2/app-server'
            }
        }
    }
}
