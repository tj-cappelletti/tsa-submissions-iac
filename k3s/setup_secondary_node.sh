#!/bin/bash

# Ensure both parameters are provided
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Usage: $0 <K3S_URL> <K3S_TOKEN> <GH_USERNAME> <GH_TOKEN>"
  exit 1
fi

K3S_PRIMARY=$1
K3S_TOKEN=$2
GH_USERNAME=$3
GH_TOKEN=$4

echo "Updating the system..."
apt update
apt upgrade -y

echo "Installing necessary packages..."
apt install qemu-guest-agent -y

echo "Installing K3s on secondary node..."
curl -sfL https://get.k3s.io | K3S_URL=https://$K3S_PRIMARY:6443 K3S_TOKEN=$K3S_TOKEN sh -

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
