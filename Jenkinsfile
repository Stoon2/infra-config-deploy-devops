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

                sh 'sudo ./util/set-env.sh'
            }
        }
        stage('cd') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rds-credentials', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh 'docker run -d -p 3000:3000 stoon2/app-server -e RDS_HOSTNAME $RDS_HOSTNAME -e RDS_PORT $RDS_PORT -e REDIS_HOSTNAME $REDIS_HOSTNAME -e REDIS_PORT $REDIS_PORT -e RDS_USERNAME ${user} -e RDS_PASSWORD ${pass}'
                }
            }
        }
    }
}
