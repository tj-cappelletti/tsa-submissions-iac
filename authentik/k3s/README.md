# authentik

## Deployment

### Namespace

```
kubectl apply -f .\authentik\k3s\namespace.yml
```

### Secrets
```
kubectl create secret tls authentik-cert-secret `
    --cert=D:\certs\auth.webstorm.cloud-crt.pem `
    --key=D:\certs\auth.webstorm.cloud-key.pem `
    --namespace authentik
```

### Helm

#### Linux
```
./deploy_helm.sh <POSTGRESQL_PASSWORD> <AUTHENTIK_SECRET_KEY>
```

#### Windows
```
helm upgrade `
   --install authentik authentik/authentik `
   -f .\authentik\values.yml `
   --namespace authentik `
   --set authentik.postgresql.password='InsertPassword' `
   --set authentik.secret_key='InsertSecretKey' `
   --set postgresql.auth.password='InsertPassword'
```