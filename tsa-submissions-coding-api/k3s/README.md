# TSA Submissions - Coding API on K3s

## Deployment

### Namespace
```
kubectl apply -f .\azure\tsa-submissions-coding-api\namespace.yml
```

### Secrets
```
kubectl create secret generic coding-secrets --namespace coding `
    --from-literal mongoDb.rootPassword=<InsertPassword> `
```

### Config Map
```
kubectl apply -f .\azure\tsa-submissions-coding-api\coding-configmap.yml
```

### MongoDB
```
kubectl apply -f .\azure\tsa-submissions-coding-api\mongodb-deployment.yml
```
