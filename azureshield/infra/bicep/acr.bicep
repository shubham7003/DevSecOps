// Azure Container Registry configuration
// Premium SKU for geo-replication and private endpoint support
param location string
param registryName string

resource acr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: registryName
  location: location
  sku: {
    name: 'Premium'
  }
  properties: {
    adminUserEnabled: false // Use Managed Identity instead of admin credentials
    publicNetworkAccess: 'Disabled' // Force Private Endpoint usage
    policies: {
      retentionPolicy: {
        days: 14 // Delete untagged manifests after 14 days
        status: 'enabled'
      }
    }
  }
}
