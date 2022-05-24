IP=$1
HOST=$2
cp /etc/hosts ~/hosts.new
sed -i "/$HOST/ s/.*/$IP\t$HOST/g" ~/hosts.new
cp -f ~/hosts.new /etc/hosts