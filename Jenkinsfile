pipeline{
    agent any
    stages{
        stage("Terraform Infra Initialized"){
            steps{
                git 'https://github.com/Stoon2/infra-config-deploy-devops'
                sh 'pwd'
                sh 'sudo terraform -chdir=terraform/ init -migrate-state'
                sh 'sudo terraform -chdir=terraform/ apply -var-file=/home/jenkins/dev.tfvars --auto-approve'
            }
            post{
                success{
                    echo "Saving Infra Config - SSH Config"
                    sh 'bastion_hostname=$(terraform output bastion_instance_ip)'
                    sh 'private_hostname=$(terraform output private_instance_ip)'
                    // sh 'source util/ssh-config.sh ${bastion_hostname:1:-1} ${private_hostname:1:-1}'
                    sh 'cat << EOF > ~/.ssh/config host bastion /n   HostName bastion_hostname /n   User ubuntu /n   identityFile ~/.ssh/myKey.pem /n /n host private_instance /n   HostName private_hostname /n   User  ubuntu /n   ProxyCommand ssh bastion -W %h:%p /n identityFile ~/.ssh/myKey.pem /n EOF'


                    // echo 'Saving Infra Config - Ansible Inventory'
                    // sh 'source util/inventory-ansible.sh ${private_hostname:1:-1})'
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
        stage("A"){
            steps{
                echo "Configuring Infra"
                sh 'ansible-playbook -i ~/inventory.ini ansible/playbook.yaml'
            }
            post{
                success{
                    echo "====++++A executed successfully++++===="
                }
                failure{
                    echo "====++++A execution failed++++===="
                }
        
            }
        }
    }
    post{
        always{
            echo "========Pipeline Finished========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}