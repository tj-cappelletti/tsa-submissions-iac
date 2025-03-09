# TSA Shared Services

## Deployment
```powershell
$timestamp = (Get-Date -AsUTC).ToFileTime() ; az deployment sub create --name "tsa-$timestamp" --location eastus --template-file .\azure\main.bicep --parameters location=eastus
```