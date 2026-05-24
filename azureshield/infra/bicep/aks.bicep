// AKS cluster configuration
// Uses system-assigned managed identity for secure Azure interactions
param location string
param clusterName string

resource aks 'Microsoft.ContainerService/managedClusters@2023-08-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned' // No static credentials used
  }
  properties: {
    dnsPrefix: '${clusterName}-dns'
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 2
        minCount: 2
        maxCount: 5
        vmSize: 'Standard_D2s_v3'
        osType: 'Linux'
        mode: 'System'
        enableAutoScaling: true
      }
    ]
    enableRBAC: true
    addonProfiles: {
      omsagent: {
        enabled: true // Enable Log Analytics Workspace integration
      }
    }
  }
}
