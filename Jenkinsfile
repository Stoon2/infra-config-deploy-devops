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
                    sh 'source util/ssh-config.sh $(terraform output bastion_instance_ip | tr -d \\\") $(terraform output private_instance_ip | tr -d \\\")'

                    echo 'Saving Infra Config - Ansible Inventory'
                    sh 'source util/inventory-ansible.sh $(terraform output private_instance_ip | tr -d \\\")'
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