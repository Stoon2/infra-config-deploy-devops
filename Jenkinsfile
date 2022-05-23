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
                    sh 'chmod +x util/ssh-config.sh'
                    sh '. ./util/ssh-config.sh $(terraform -chdir=terraform/ output --raw bastion_instance_ip) $(terraform -chdir=terraform/ output --raw private_instance_ip)'

                    echo 'Saving Infra Config - Ansible Inventory'
                    sh 'chmod +x util/inventory-ansible.sh'
                    sh '. ./util/inventory-ansible.sh $(terraform -chdir=terraform/ output --raw private_instance_ip)'
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