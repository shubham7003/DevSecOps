// Main Bicep entry point
// Connects AKS, ACR, and KeyVault modules using Managed Identity
param location string = resourceGroup().location
@allowed([
  'dev'
  'staging'
  'prod'
])
param environment string
param clusterName string

module aks './aks.bicep' = {
  name: 'aksDeployment'
  params: {
    location: location
    clusterName: clusterName
  }
}

module acr './acr.bicep' = {
  name: 'acrDeployment'
  params: {
    location: location
    registryName: 'acr${environment}${uniqueString(resourceGroup().id)}'
  }
}

module keyvault './keyvault.bicep' = {
  name: 'kvDeployment'
  params: {
    location: location
    vaultName: 'kv-${environment}-${uniqueString(resourceGroup().id)}'
  }
}
