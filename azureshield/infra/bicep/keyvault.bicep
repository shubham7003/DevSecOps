// Azure Key Vault configuration
// Centralizes all secrets using RBAC to eliminate pipeline variables
param location string
param vaultName string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: vaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: true // Modern RBAC over access policies
  }
}
