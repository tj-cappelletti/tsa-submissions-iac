echo "Updating the system..."
apt update
apt upgrade -y

echo "Installing necessary packages..."
apt install qemu-guest-agent -y

echo "Installing HAProxy..."
apt install haproxy -y

echo "Configuring HAProxy..."
cat << EOF >> /etc/haproxy/haproxy.cfg

frontend tsa
        bind *:80
        default_backend tsa_servers

backend tsa_servers
        balance roundrobin
        server tsa_k3s_01 k3s01.tsa.local.webstorm.cloud:80 check
        server tsa_k3s_02 k3s02.tsa.local.webstorm.cloud:80 check
        server tsa_k3s_03 k3s03.tsa.local.webstorm.cloud:80 check
EOF

echo "Restarting HAProxy service..."
sudo systemctl restart haproxy
sudo systemctl enable haproxy
