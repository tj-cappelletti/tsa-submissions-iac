#!/bin/bash

# Ensure both parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <POSTGRESQL_PASSWORD> <AUTHENTIK_SECRET_KEY>"
  exit 1
fi

POSTGRESQL_PASSWORD=$1
AUTHENTIK_SECRET_KEY=$2
NAMESPACE="authentik"

echo "Deploying Authentik to K3s cluster..."
echo "Creating namespace for Authentik..."
kubectl apply -f namespace.yml

echo "Installing Authentik using Helm..."
helm upgrade \
   --install authentik authentik/authentik \
   -f values.yml \
   --namespace authentik \
   --set authentik.postgresql.password="$POSTGRESQL_PASSWORD" \
   --set authentik.secret_key="$AUTHENTIK_SECRET_KEY" \
   --set postgresql.auth.password="$POSTGRESQL_PASSWORD"