pipeline{
    ageny any
    agent{
        label "node"
    }
    stages{
        stage("Terraform Infra Initialized"){
            steps{
                git 'https://github.com/Stoon2/infra-config-deploy-devops'
                sh 'sudo terraform init -chdir=terraform/ -migrate-state'
                sh 'sudo terraform apply -var-file=~/dev.tfvars --auto-approve'
            }
            post{
                success{
                    echo "Saving Infra Config - SSH Config"
                    sh 'source util/ssh-config.sh $(terraform output bastion_instance_ip | tr -d \") $(terraform output private_instance_ip | tr -d \")'

                    echo 'Saving Infra Config - Ansible Inventory'
                    sh 'source util/inventory-ansible.sh $(terraform output private_instance_ip | tr -d \")'
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