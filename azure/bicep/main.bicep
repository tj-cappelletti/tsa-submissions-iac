import * as locations from 'functions/location.bicep'

targetScope = 'subscription'

@description('The timestamp of the deployment. This is used to create a unique name for all deployments. It defaults to the current time in epoch format.')
param deploymentTimestamp string = string(dateTimeToEpoch(utcNow()))

@allowed(['centralus', 'eastus', 'eastus2', 'northcentralus', 'southcentralus', 'westcentralus', 'westus', 'westus2'])
@description('The location to deploy the TSA resources to.')
param location string

var applicationName = 'Submissions'
var managedClusterName = 'tsa-${toLower(applicationName)}-${locations.getLocationShortCode(location)}-aks'
var resourceGroupName = 'tsa-${toLower(applicationName)}-${locations.getLocationShortCode(location)}-rg'

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.1' = {
  name: 'resourceGroupDeployment-${deploymentTimestamp}'
  params: {
    location: location
    name: resourceGroupName
  }
}

module managedCluster 'br/public:avm/res/container-service/managed-cluster:0.8.3' = {
  name: 'managedClusterDeployment-${deploymentTimestamp}'
  dependsOn: [
    resourceGroup
  ]
  scope: az.resourceGroup(resourceGroupName)
  params: {
    // Required parameters
    name: managedClusterName
    primaryAgentPoolProfiles: [
      {
        availabilityZones: [1]
        count: 1
        mode: 'System'
        name: 'systempool'
        vmSize: 'Standard_D4ads_v5'
      }
    ]
    agentPools: [
      {
        availabilityZones: [1]
        count: 2
        mode: 'User'
        name: 'workerpool'
        vmSize: 'Standard_D4ads_v5'
      }
    ]
    disableLocalAccounts: false
    enableStorageProfileBlobCSIDriver: true
    enableStorageProfileFileCSIDriver: true
    enableStorageProfileDiskCSIDriver: true
    enableStorageProfileSnapshotController: true
    ingressApplicationGatewayEnabled: true
    managedIdentities: {
      systemAssigned: true
    }
    publicNetworkAccess: 'Enabled'
    webApplicationRoutingEnabled: true
  }
}
