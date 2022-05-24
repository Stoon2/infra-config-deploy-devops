IP=$1
HOST=$2

sed -i "/$HOST/ s/.*/$IP\t$HOST/g" /etc/hosts