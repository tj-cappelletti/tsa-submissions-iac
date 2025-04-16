#!/bin/bash

# Ensure both parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <GH_USERNAME> <GH_TOKEN>"
  exit 1
fi
# Assign parameters to variables
GH_USERNAME=$1
GH_TOKEN=$2

echo "Updating the system..."
apt update
apt upgrade -y

echo "Installing necessary packages..."
apt install qemu-guest-agent -y

echo "Installing K3s on primary node..."
curl -sfL https://get.k3s.io | sh -

echo "Installing Helm..."
snap install helm --classic

echo "Adding Authentik Helm repository..."
helm repo add authentik https://charts.goauthentik.io
helm repo update

echo "Creating kubeconfig directory..."
mkdir -p $HOME/.kube
chown tsa:tsa $HOME/.kube

echo "Copying K3s kubeconfig to user's kube directory..."
cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config

echo "Setting permissions for kubeconfig..."
chown tsa:tsa $HOME/.kube/config

echo "Setting KUBECONFIG environment variable..."
export KUBECONFIG=~/.kube/config
echo "export KUBECONFIG=$HOME/.kube/config" >> $HOME/.bashrc

echo "Adding GitHub Container Registry configuration..."
cat <<EOF > /etc/rancher/k3s/registries.yaml
mirrors:
  "ghcr.io":
    endpoint:
      - "https://ghcr.io"
configs:
  "ghcr.io":
    auth:
      username: "$GH_USERNAME"
      password: "$GH_TOKEN"
EOF

echo "Restarting K3s service..."
systemctl restart k3s
