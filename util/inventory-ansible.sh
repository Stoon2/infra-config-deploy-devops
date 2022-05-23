sudo cat << EOF > ~/inventory.ini
[app-deployment]
server-a ansible_host=$1 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/myKey.pem
[app-deployment:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -W %h:%p -q bastion"'
EOF