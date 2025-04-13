# TSA Submissions - Coding API

## Deployment

### Namespace
```
kubectl apply -f .\azure\tsa-submissions-coding-api\namespace.yml
```

### Secrets
```
kubectl create secret generic coding-secrets --namespace coding `
    --from-literal mongoDb.rootPassword=<InsertPassword> `
    --from-literal mongoDb.connectionString=<InsertConnectionString>
```

### Config Map
```
kubectl apply -f .\azure\tsa-submissions-coding-api\coding-configmap.yml
```

### MongoDB
```
kubectl apply -f .\azure\tsa-submissions-coding-api\mongodb-deployment.yml
```
