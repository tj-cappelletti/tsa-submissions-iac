if [ -z "$1" ]; then
    echo "Usage: $0 <password>"
    exit 1
fi

PASSWORD=$1
NAMESPACE="coding"

echo "Deploying TSA Submissions Coding API to K3s cluster..."

echo "Creating namespace for TSA Submissions Coding API..."
kubectl apply -f namespace.yml

echo "Creating ConfigMap for TSA Submissions Coding API..."
kubectl apply -f coding-configmap.yml --namespace $NAMESPACE

echo "Creating Secret for TSA Submissions Coding API..."

if kubectl get secret coding-secrets --namespace $NAMESPACE; then
    echo "Secret already exists. Updating the password..."
    kubectl delete secret coding-secrets --namespace $NAMESPACE
fi

kubectl create secret generic coding-secrets \
    --namespace $NAMESPACE \
    --from-literal database.submissions.password="$PASSWORD"

echo "Creating MongoDB deployment and services..."
kubectl apply -f mongodb-deployment.yml --namespace $NAMESPACE

echo "Creating TSA Submissions Coding API deployment and services..."
kubectl apply -f api-deployment.yml --namespace $NAMESPACE
