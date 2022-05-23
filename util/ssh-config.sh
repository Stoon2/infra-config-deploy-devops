# sudo chmod 400 /home/jenkins/myKey.pem
cat << EOF > ~/.ssh/config
host bastion
   HostName $1
   User ubuntu
   identityFile ~/.ssh/myKey.pem

host private_instance
   HostName $2
   User  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   identityFile ~/.ssh/myKey.pem
EOF