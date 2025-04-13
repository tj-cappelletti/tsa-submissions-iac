# TSA Submissions IaC
This repository contains the necessary infrastructure as code (IaC), Kubernetes deployments, and scripts to setup the servers to be used by the TSA Submissions applications.

## Deployment
```powershell
$timestamp = (Get-Date -AsUTC).ToFileTime() ; az deployment sub create --name "tsa-$timestamp" --location eastus --template-file .\azure\main.bicep --parameters location=eastus
```